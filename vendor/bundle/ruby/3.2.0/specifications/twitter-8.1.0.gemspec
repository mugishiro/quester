# -*- encoding: utf-8 -*-
# stub: twitter 8.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "twitter".freeze
  s.version = "8.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Erik Berlin".freeze, "John Nunemaker".freeze, "Wynn Netherland".freeze, "Steve Richert".freeze, "Steve Agalloco".freeze]
  s.date = "2024-04-30"
  s.description = "A Ruby interface to the Twitter API.".freeze
  s.email = ["sferik@gmail.com".freeze]
  s.homepage = "https://sferik.github.io/twitter/".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\u{1F4E3} Attention Twitter Ruby Gem User!\nIf you're seeing this message, that means you're using the old Twitter Ruby gem\nwhich is no longer maintained and will not support Twitter API v2.\n\n\u{1F389} Here's the good news:\nWe recommend switching to the X gem, which supports both API v1.1 and v2. It's\na robust, modern libary that is designed to ensure you'll be able to easily\nintegrate forthcoming API changes.\n\n\u{1F517} For more details, visit: https://sferik.github.io/x-ruby/\n\n\u{1F914} Please consider sponsoring\nThe X gem is free to use, but with new API pricing tiers, it actually costs\nmoney to develop and maintain. By contributing to the project, you help:\n\n1. \u{1F6E0}  Maintain the library: Keeping it up-to-date and secure.\n2. \u{1F308} Add new features: Enhancements that make your life easier.\n3. \u{1F4AC} Provide support: Faster responses to issues and feature requests.\n\u2B50\uFE0F Bonus: Sponsors will get priority influence over the project roadmap.\nYour company's logo will also be displayed on the project's GitHub page.\n\n\u{1F517} To sponsor, visit: https://github.com/sponsors/sferik\n\nBuilding and maintaining an open-source project like this takes a considerable\namount of time and effort. Your sponsorship can help sustain this project. Even\na small monthly donation makes a big difference!\n\n\u{1F496} Thanks for considering sponsorship. Together we can make the X gem even better!\n".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 3.1.4".freeze)
  s.rubygems_version = "3.4.19".freeze
  s.summary = "A Ruby interface to the Twitter API.".freeze

  s.installed_by_version = "3.4.19" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.8"])
  s.add_runtime_dependency(%q<buftok>.freeze, ["~> 0.3.0"])
  s.add_runtime_dependency(%q<equalizer>.freeze, ["~> 0.0.11"])
  s.add_runtime_dependency(%q<http>.freeze, ["~> 5.2"])
  s.add_runtime_dependency(%q<http-form_data>.freeze, ["~> 2.3"])
  s.add_runtime_dependency(%q<llhttp-ffi>.freeze, ["~> 0.5.0"])
  s.add_runtime_dependency(%q<memoizable>.freeze, ["~> 0.4.0"])
  s.add_runtime_dependency(%q<multipart-post>.freeze, ["~> 2.4"])
  s.add_runtime_dependency(%q<naught>.freeze, ["~> 1.1"])
  s.add_runtime_dependency(%q<simple_oauth>.freeze, ["~> 0.3.0"])
end
