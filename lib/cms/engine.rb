require 'myengine'
require 'redcarpet'
require 'twitter-bootstrap-rails'
require 'later_dude'
require 'truncate_html'
require 'mongoid_paperclip'
require 'tinymce-rails'


module Cms
  class Engine < Rails::Engine
    isolate_namespace Cms
    
  end
end
