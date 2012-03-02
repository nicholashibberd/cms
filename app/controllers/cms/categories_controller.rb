module Cms
  class CategoriesController < Cms::AdminController  
    def category_articles
      @category = Category.find_by_slug(params[:category_id])
      @articles = @category.find_articles_by_church(@institution, params[:month])
      @snippet_size = 300
    end
  
    def show
      @category = Category.find_by_slug(params[:id])
      @articles = @category.articles
    end
    
    def index
      @categories = Category.all
    end
    
    def new
      @category = Category.new
    end
    
    def edit
      @category = Category.find_by_slug(params[:id])
    end
    
    def create
      @category = Category.new(params[:category])
      if @category.save
        redirect_to(categories_path, :notice => "Category was successfully created")
      else
        flash[:error] = "There was an error creating the Category"
        render :action => "new"
      end
    end
    
    def update
      category = Category.find_by_slug(params[:id])
  		category.update_attributes(params[:category])
  		redirect_to categories_path
    end
  
  end
end