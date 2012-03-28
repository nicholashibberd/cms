$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cms"
  s.version     = Cms::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Cms."
  s.description = "TODO: Description of Cms."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "redcarpet"
  s.add_dependency 'mongoid'
  s.add_dependency 'bson_ext'
  s.add_dependency 'jquery-rails'
  s.add_dependency "mongoid-paperclip"
  s.add_dependency "twitter-bootstrap-rails"
  s.add_dependency "later_dude"
  s.add_dependency "truncate_html"
  s.add_dependency "rack-cache"
  s.add_dependency "tinymce-rails"
  s.add_dependency "dragonfly", '~>0.9.10'

  s.add_development_dependency "sqlite3"  
end
