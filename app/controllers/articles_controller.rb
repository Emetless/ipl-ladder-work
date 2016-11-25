class ArticlesController < ApplicationController
  def index
    @articles = Article.where author_id: current_user.id
    @edit = true
  end

  def user
    @articles = Article.where author_id: params[:id]
    @edit = false
    render :index
  end

  def new
  end

  def create
    article = Article.new do |article|
      article.author_id = current_user.id
      article.content = params[:content]
    end
    article.save
    redirect_to articles_index_path
  end

  def edit
    @article = Article.find_by_id params[:article_id]
  end

  def update
    @article = Article.find_by_id params[:article_id]
    @article.update content: params[:content]
    redirect_to articles_index_path
  end
end
