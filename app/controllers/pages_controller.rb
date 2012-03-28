class PagesController < ApplicationController
  def show
    @page = Page.find_by_slug(params[:id])
    @group = @page.group
  end
  
  def group_homepage
    @group = Group.find_by_slug(params[:id])
    @page = @group.homepage
    render 'show'
  end
end