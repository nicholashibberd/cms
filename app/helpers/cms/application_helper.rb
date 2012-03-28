module Cms
  module ApplicationHelper
    def login_required
      raise 'is login required?'
    end
    
    def current_controller
      request[:controller].gsub('cms/', '')
    end
        
  end
end
