# -*- encoding: utf-8 -*-
# stub: mongoid-rspec 4.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mongoid-rspec".freeze
  s.version = "4.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Evan Sagge".freeze, "Rodrigo Pinto".freeze]
  s.date = "2018-06-18"
  s.description = "RSpec matches for Mongoid models, including association and validation matchers.".freeze
  s.email = "evansagge@gmail.com contato@rodrigopinto.me".freeze
  s.homepage = "http://github.com/mongoid-rspec/mongoid-rspec".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "RSpec matchers for Mongoid".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<mongoid>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<rspec>.freeze, ["~> 3.3"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_runtime_dependency(%q<mongoid-compatibility>.freeze, [">= 0.5.1"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<mongoid>.freeze, [">= 3.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<mongoid-compatibility>.freeze, [">= 0.5.1"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<mongoid>.freeze, [">= 3.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<mongoid-compatibility>.freeze, [">= 0.5.1"])
  end
end
