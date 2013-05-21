# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mail_view"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Peek"]
  s.date = "2012-06-27"
  s.email = "josh@joshpeek.com"
  s.homepage = "https://github.com/37signals/mail_view"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Visual email testing"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tilt>, [">= 0"])
    else
      s.add_dependency(%q<tilt>, [">= 0"])
    end
  else
    s.add_dependency(%q<tilt>, [">= 0"])
  end
end
