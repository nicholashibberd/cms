class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @article.comments << Comment.new(params[:comment])
    page = Page.find(params[:page_id]) rescue nil
    path = page ? page_path(page) : article_path(@article)
    redirect_to path
  end
end