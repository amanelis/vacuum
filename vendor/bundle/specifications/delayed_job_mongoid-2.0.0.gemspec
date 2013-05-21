# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "delayed_job_mongoid"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Gaffney", "Brandon Keepers"]
  s.date = "2012-08-02"
  s.email = ["chris@collectiveidea.com", "brandon@opensoul.com"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/collectiveidea/delayed_job_mongoid"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Mongoid backend for delayed_job"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, ["~> 3.0"])
      s.add_runtime_dependency(%q<delayed_job>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0"])
      s.add_development_dependency(%q<rake>, [">= 0.9"])
      s.add_development_dependency(%q<simplecov>, [">= 0.6"])
    else
      s.add_dependency(%q<mongoid>, ["~> 3.0"])
      s.add_dependency(%q<delayed_job>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, [">= 2.0"])
      s.add_dependency(%q<rake>, [">= 0.9"])
      s.add_dependency(%q<simplecov>, [">= 0.6"])
    end
  else
    s.add_dependency(%q<mongoid>, ["~> 3.0"])
    s.add_dependency(%q<delayed_job>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, [">= 2.0"])
    s.add_dependency(%q<rake>, [">= 0.9"])
    s.add_dependency(%q<simplecov>, [">= 0.6"])
  end
end
