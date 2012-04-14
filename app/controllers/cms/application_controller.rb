module Cms
  class ApplicationController < ActionController::Base
    before_filter :setup
    
    def setup
      @group = params[:group_id] ? Group.find_by_slug(params[:group_id]) : nil
      @group_id = @group ? @group.id : nil
      raise [params, @group, @group_id].inspect      
    end
        
  end
end
