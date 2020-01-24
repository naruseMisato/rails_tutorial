# Copyright (C) 2019 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  class Cluster

    # Periodically retrieves SRV records for the cluster's SRV URI, and
    # sets the cluster's server list to the SRV lookup result.
    #
    # If an error is encountered during SRV lookup or an SRV record is invalid
    # or disallowed for security reasons, a warning is logged and monitoring
    # continues.
    #
    # @api private
    class SrvMonitor
      include Loggable
      include BackgroundThread

      MIN_SCAN_INTERVAL = 60

      DEFAULT_TIMEOUT = 10

      # Creates the SRV monitor.
      #
      # @param [ Cluster ] cluster The cluster.
      # @param [ Hash ] options The cluster options.
      #
      # @option options [ Float ] :timeout The timeout to use for DNS lookups.
      # @option options [ URI::SRVProtocol ] :srv_uri The SRV URI to monitor.
      # @option options [ Hash ] :resolv_options For internal driver use only.
      #   Options to pass through to Resolv::DNS constructor for SRV lookups.
      def initialize(cluster, options = nil)
        options = if options
          options.dup
        else
          {}
        end
        @cluster = cluster
        @resolver = Srv::Resolver.new(options)
        unless @srv_uri = options.delete(:srv_uri)
          raise ArgumentError, 'SRV URI is required'
        end
        @options = options.freeze
        @last_result = @srv_uri.srv_result
        @stop_semaphore = Semaphore.new
      end

      attr_reader :options

      attr_reader :cluster

      # @return [ Srv::Result ] Last known SRV lookup result. Used for
      #   determining intervals between SRV lookups, which depend on SRV DNS
      #   records' TTL values.
      attr_reader :last_result

      def start!
        super
        ObjectSpace.define_finalizer(self, self.class.finalize(@thread))
      end

      private

      def do_work
        scan!
        @stop_semaphore.wait(scan_interval)
      end

      def scan!
        old_hosts = last_result.address_strs

        begin
          last_result = Timeout.timeout(timeout) do
            @resolver.get_records(@srv_uri.query_hostname)
          end
        rescue Resolv::ResolvTimeout => e
          log_warn("SRV monitor: timed out trying to resolve hostname #{@srv_uri.query_hostname}: #{e.class}: #{e}")
          return
        rescue Timeout::Error
          log_warn("SRV monitor: timed out trying to resolve hostname #{@srv_uri.query_hostname} (timeout=#{timeout})")
          return
        rescue Resolv::ResolvError => e
          log_warn("SRV monitor: unable to resolve hostname #{@srv_uri.query_hostname}: #{e.class}: #{e}")
          return
        end

        if last_result.empty?
          log_warn("SRV monitor: hostname #{@srv_uri.query_hostname} resolved to zero records")
          return
        end

        @cluster.set_server_list(last_result.address_strs)
      end

      def self.finalize(thread)
        Proc.new do
          thread.kill
        end
      end

      def scan_interval
        if last_result.empty?
          [cluster.heartbeat_interval, MIN_SCAN_INTERVAL].min
        elsif last_result.min_ttl.nil?
          MIN_SCAN_INTERVAL
        else
          [last_result.min_ttl, MIN_SCAN_INTERVAL].max
        end
      end

      def timeout
        options[:timeout] || DEFAULT_TIMEOUT
      end
    end
  end
end
