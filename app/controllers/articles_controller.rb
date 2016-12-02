class ArticlesController < ApplicationController
  def index
    @articles = Article.where author_id: current_user.id
    @edit = true
  end

  def user
    @articles = Article.where author_id: params[:id]
    @edit = params[:id] == current_user.id.to_s
    render :index
  end

  def users
    @users = User.all
  end

  def new
  end

  def create
    @article = Article.new do |article|
      article.author_id = current_user.id
      article.content = article_new_content
    end
    article_new_content && @article.save
    redirect_to root_path
  end

  def edit
    set_artcile
    redirect_to articles_index_path unless @article
  end

  def update
    set_artcile
    @article.update content: article_new_content
    redirect_to root_path
  end

  def destroy
    set_artcile
    @article.destroy
    redirect_to root_path
  end

  private
    def set_artcile
      searched_article = Article.find params.require(:article)[:id]
      if searched_article.author_id == current_user.id.to_s
        @article = searched_article
      end
    end

    def article_new_content
      params.require(:content)
    end
end
