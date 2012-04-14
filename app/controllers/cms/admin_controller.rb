module Cms
  class AdminController < ApplicationController
    protect_from_forgery
  
    before_filter :login_required, :setup
  
    def login_required
    end
    
    def setup
      @group = params[:group_id] ? Group.find_by_slug(params[:group_id]) : nil
      @group_id = @group ? @group.id : nil
    end
    
    def home

    end
  end
end