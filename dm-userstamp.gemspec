# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-userstamp}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Livsey"]
  s.date = %q{2009-10-29}
  s.email = %q{richard@livsey.org}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.txt"
  ]
  s.files = [
    ".DS_Store",
     "History.txt",
     "LICENSE",
     "README.txt",
     "Rakefile",
     "TODO",
     "lib/.DS_Store",
     "lib/dm-userstamp.rb",
     "lib/dm-userstamp/version.rb",
     "spec/.DS_Store",
     "spec/integration/userstamp_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/rlivsey/dm-userstamp}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{DataMapper plugin to add automatic updating of created_by_id and updated_by_id attributes}
  s.test_files = [
    "spec/integration/userstamp_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
