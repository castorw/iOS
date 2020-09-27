# -*- encoding: utf-8 -*-
# stub: cocoapods-acknowledgements 1.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-acknowledgements".freeze
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fabio Pelosin".freeze, "Orta Therox".freeze, "Marcelo Fabri".freeze]
  s.date = "2016-04-15"
  s.homepage = "https://github.com/CocoaPods/cocoapods-acknowledgements".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "CocoaPods plugin that generates an acknowledgements plist to make it easy to create tools to use in apps.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<redcarpet>.freeze, ["~> 3.3"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.3"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
