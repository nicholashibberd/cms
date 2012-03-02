module Cms
  class AdminController < ApplicationController
    protect_from_forgery
  
    before_filter :login_required
  
    def login_required
    end
    
    def home

    end
  end
end