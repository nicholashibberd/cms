module Cms
  class GroupsController < Cms::AdminController  
    def show
      @group = Group.find_by_slug(params[:id])
    end
    
    def index
      @groups = Group.all
    end
    
    def update
      group = Group.find_by_slug(params[:id])
      group.update_attributes(params[:group])
      redirect_to group_path(group)
    end
  end
end