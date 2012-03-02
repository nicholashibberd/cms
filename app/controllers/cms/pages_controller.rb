module Cms
  class PagesController < Cms::AdminController

    def new
      @page = case params[:page_type]
        when 'articles' then ArticlesPage.new
        when 'calendar' then CalendarPage.new
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
      @pages = Page.all
    end

    def create
      page = case params[:page_type]
        when 'articles_page' then ArticlesPage.new(params[:articles_page])
        when 'calendar_page' then CalendarPage.new(params[:calendar_page])
        else ContentPage.new(params[:content_page])
      end
      if page.save
        redirect_to pages_path, :notice => "Successfully created page"
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
        else params[:content_page]
      end
  		page.update_attributes(page_type_params)
  		redirect_to pages_path
  	end

  	def	destroy
  		page = Page.find_by_slug(params[:id])
  		page.destroy
  		redirect_to pages_path
  	end
  	
  	def order_widgets
      Widget.order_widgets(params[:widgets])
      render :nothing => true
    end
    
  end
end
