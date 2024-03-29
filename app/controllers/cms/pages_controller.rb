module Cms
  class PagesController < Cms::AdminController

    def new
      @page = case params[:page_type]
        when 'articles' then ArticlesPage.new
        when 'calendar' then CalendarPage.new
        when 'homepage' then Homepage.new
        when 'profile' then ProfilePage.new
        else ContentPage.new
      end
    end

    def edit
      @page = Page.find_by_slug(params[:id])
    end

    def show 
      @page = Page.find_by_slug(params[:id])
    end

    def index
      @pages = @group ? @group.pages : Page.top_level
    end

    def create
      page = case params[:page_type]
        when 'articles_page' then ArticlesPage.new(params[:articles_page])
        when 'calendar_page' then CalendarPage.new(params[:calendar_page])
        when 'homepage' then Homepage.new(params[:homepage])          
        when 'profile_page' then ProfilePage.new(params[:profile_page])          
        when 'html_page' then HtmlPage.new(params[:html_page])
        else ContentPage.new(params[:content_page])
      end
      if page.save
    		redirect_to edit_page_path(@group, page), :notice => 'Page successfully created'
      else
        flash[:error] = "There was an error creating the page"
        render :action => 'new'
      end  		
    end

  	def	update
  		page = Page.find_by_slug(params[:id])
    	page_type_params = case params[:page_type]
		    when 'articles_page' then params[:articles_page]
	      when 'calendar_page' then params[:calendar_page]
	      when 'homepage' then params[:homepage]
	      when 'profile_page' then params[:profile_page]
        when 'html_page' then params[:html_page]
        else params[:content_page]
      end
      page.update_page(page_type_params)
  		redirect_to pages_path(@group)
  	end

  	def	destroy
  		page = Page.find_by_slug(params[:id])
  		page.destroy
      flash[:error] = "Page successfully deleted"  		
  		redirect_to pages_path(@group)
  	end
  	
  	def order_widgets
      Widget.order_widgets(params[:widgets])
      render :nothing => true
    end
    
    def layout
      page = Page.find_by_slug(params[:page_id])
      page.save_regions(params[:page][:regions].values)
      render :nothing => true
    end
    
    def add_panel
      page = Page.find_by_slug(params[:id])
      region = page.regions.by_slug(params[:region])
      region.add_panel
      redirect_to :back
    end

    def add_row
      page = Page.find_by_slug(params[:id])
      page.create_rows(params[:template])
      redirect_to :back
    end

    def add_sub_region
      region = Region.find(params['region_id'])
      region.add_sub_region(params['sub_region'])
      redirect_to :back
    end
    
    def add_region
      page = Page.find(params[:page_id])
      page.add_region(params['region'])
      redirect_to :back
    end

    def add_region_rows
      region = Region.find(params['region_id'])
      region.add_row(nil)
      redirect_to :back
    end

    def split_panel
      page = Page.find_by_slug(params[:id])
      region = page.regions.by_slug(params[:region])
      panel = region.panels.find(params[:panel])      
      panel.split(params[:columns])
      redirect_to :back
    end
    
    def update_row
      row = Row.find(params[:row_id])
      row.update_attributes(params[:row])
      redirect_to :back
    end
    
  end
end
