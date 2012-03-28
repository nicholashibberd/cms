class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end
  
  def index
    @category = Category.find_by_slug(params[:category_id])
    @group = Group.find_by_slug(params[:group_id])
  end
end