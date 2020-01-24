# Copyright (C) 2014-2019 MongoDB Inc.
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

require 'mongo/auth/x509/conversation'

module Mongo
  module Auth

    # Defines behavior for X.509 authentication.
    #
    # @since 2.0.0
    # @api private
    class X509

      # The authentication mechinism string.
      #
      # @since 2.0.0
      MECHANISM = 'MONGODB-X509'.freeze

      # @return [ Mongo::Auth::User ] The user to authenticate.
      attr_reader :user

      # Instantiate a new authenticator.
      #
      # @example Create the authenticator.
      #   Mongo::Auth::X509.new(user)
      #
      # @param [ Mongo::Auth::User ] user The user to authenticate.
      #
      # @since 2.0.0
      def initialize(user)
        # The only valid database for X.509 authentication is $external.
        if user.auth_source != '$external'
          user_name_msg = if user.name
            " #{user.name}"
          else
            ''
          end
          raise Auth::InvalidConfiguration, "User#{user_name_msg} specifies auth source '#{user.auth_source}', but the only valid auth source for X.509 is '$external'"
        end

        @user = user
      end

      # Log the user in on the given connection.
      #
      # @example Log the user in.
      #   user.login(connection)
      #
      # @param [ Mongo::Connection ] connection The connection to log into.
      #   on.
      #
      # @return [ Protocol::Message ] The authentication response.
      #
      # @since 2.0.0
      def login(connection)
        conversation = Conversation.new(user)
        reply = connection.dispatch([ conversation.start(connection) ])
        connection.update_cluster_time(Operation::Result.new(reply))
        conversation.finalize(reply, connection)
      end
    end
  end
end
