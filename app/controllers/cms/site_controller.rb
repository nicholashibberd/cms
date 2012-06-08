module Cms
  class SiteController < Cms::AdminController  
    def edit
      @site = Site.instance
    end
    
    def update
      Site.instance.update_attributes(params[:site])
      redirect_to admin_home_path
    end
  end
end