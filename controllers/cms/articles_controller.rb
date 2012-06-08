module Cms
  class ArticlesController < Cms::AdminController  
  
    def index
      @articles = Article.all
    end
  
    def edit
      @article = Article.find(params[:id])
      @category = @article.category
    end
  
    def new
      @category = Category.find_by_slug(params[:category_id])
      @article = Article.new
    end
  
    def show
      @article = Article.find(params[:id])
      @comment = @article.comments.new
    end
  
    def create
      @article = Article.new(params[:article])
      category = @article.category
      if @article.save
        redirect_to(category_path(@group, category), :notice => "#{category.name.singularize} was successfully created")
      else
        flash[:error] = "There was an error creating the #{category.name.singularize}"
        render :action => "new"
      end
    end

    def update
      @article = Article.find(params[:id])
      category = @article.category    
      if @article.update_attributes(params[:article])
        redirect_to(category_path(@group, category), :notice => "#{category.name.singularize} was successfully updated.")
      else
        flash[:error] = "There was an error updating the #{category.name.singularize}"      
        render :action => "edit"
      end
    end

    def destroy
      article = Article.find(params[:id])
      category = article.category
      article.destroy
      redirect_to category_path(@group, category)
    end
  
  end
end