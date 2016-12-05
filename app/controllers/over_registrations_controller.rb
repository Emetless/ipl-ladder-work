class OverRegistrationsController < Devise::RegistrationsController
  def new
    @page_name = t('sign_up')
    super
  end

  def create
    @page_name = t('sign_up')
    super
  end

  def edit
    @page_name = t('edit_info')
    super
  end

  def update
    @page_name = t('edit_info')
    super
  end

  def destroy
    Article.where(author_id: current_user.id).each(&:delete)
    Comment.where(author_id: current_user.id).each(&:delete)
    super
  end
end 
