module Cms
  class NavMenusController < Cms::AdminController

    def index
      @nav_menus = @group ? @group.nav_menus : NavMenu.top_level
    end

    def new
      @nav_menu = NavMenu.new
    end

    def edit
      @nav_menu = NavMenu.find(params[:id])
    end

    def create
      nav_menu = NavMenu.new(params[:nav_menu])
    
      if nav_menu.save
    		redirect_to nav_menus_path(@group), :notice => "Successfully created navigation menu"
      else
        flash[:error] = "Nav Menu could not be created"
        render :action => "new"
      end
    end

    def update
      @nav_menu = NavMenu.find(params[:id])

      if @nav_menu.update_attributes(params[:nav_menu])
    		redirect_to nav_menus_path(@group), :notice => "Successfully created navigation menu"
      else
        flash[:error] = "Nav Menu could not be updated"
        render :action => "edit"
      end
    end

    def destroy
      @nav_menu = NavMenu.find(params[:id])
      @nav_menu.destroy

      redirect_to nav_menus_path(@group)
    end
  
  end
end
