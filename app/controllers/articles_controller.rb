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
    @article = Article.new(article_params_content)
    @article.author_id = current_user.id
    @article.save
    redirect_to root_path
  end

  def edit
    redirect_to articles_index_path unless set_artcile
  end

  def update
    set_artcile
    @article.update article_params_content
    redirect_to root_path
  end

  def destroy
    set_artcile
    @article.destroy
    redirect_to root_path
  end

  private

    def set_artcile
      searched_article = Article.find params.require(:article).permit(:id)[:id]
      if searched_article.author_id == current_user.id.to_s
        @article = searched_article
      end
    end

    def article_params_content
      params.require(:article).permit(:content)
    end
end
