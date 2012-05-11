module Cms
  module ApplicationHelper
    def login_required
      raise 'is login required?'
    end
    
    def current_controller
      request[:controller].gsub('cms/', '')
    end
    
    def show_editing_tools?
      request[:action] == 'edit'
    end
        
  end
end
