module Cms
  class CmsController < ActionController::Base
    before_filter :setup
    
    def setup
      @group = params[:group_id] ? Group.find_by_slug(params[:group_id]) : nil
      @group_id = @group ? @group.id : nil
    end
        
  end
end
