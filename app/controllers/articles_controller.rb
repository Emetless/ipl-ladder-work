class ArticlesController < ApplicationController
  # before_filter :authenticate_user!
  def index
    @articles = Article.all
  end

  def edit
  end

  def new
    article = Article.new do |article|
      article.author_id = 1
      article.content = params[:content]
    end
    article.save
    redirect_to articles_index_path
  end
end
