# -*- encoding: utf-8 -*-
# stub: buftok 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "buftok".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tony Arcieri".freeze, "Martin Emde".freeze, "Erik Michaels-Ober".freeze]
  s.date = "2021-03-25"
  s.description = "BufferedTokenizer extracts token delimited entities from a sequence of string inputs".freeze
  s.email = ["sferik@gmail.com".freeze, "martin.emde@gmail.com".freeze]
  s.homepage = "https://github.com/sferik/buftok".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.19".freeze
  s.summary = "BufferedTokenizer extracts token delimited entities from a sequence of string inputs".freeze

  s.installed_by_version = "3.4.19" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 1.17"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
  s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
end
