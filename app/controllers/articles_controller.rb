class ArticlesController < ApplicationController
  def home
    @page_name = t('home_page')
  end

  def user
    @page_name = "#{t('page_of')} #{User.find(params[:id]).email}"
  end

  def users
    @page_name = t('all_users')
    @users = User.all
  end

  def new
    @page_name = t('new_article')
  end

  def create
    @article = Article.new(article_params_content)
    @article.author_id = current_user.id
    @article.save
    redirect_to root_path
  end

  def edit
    @page_name = t('edit_article')
    redirect_to root_path unless set_artcile
  end

  def update
    set_artcile
    @article.update article_params_content
    return redirect_to user_path(@article.author_id) if current_user.admin?
    redirect_to root_path
  end

  def destroy
    set_artcile
    @article.destroy
    return redirect_to user_path(@article.author_id) if current_user.admin?
    redirect_to root_path
  end

  private

    def set_artcile
      searched_article = Article.find params.require(:article).permit(:id)[:id]
      if current_user.admin? || searched_article.author_id == current_user.id.to_s
        @article = searched_article
      end
    end

    def article_params_content
      params.require(:article).permit(:content)
    end
end
