class OverSessionsController < Devise::SessionsController
  def new
    @page_name = t('sign_in')
    super
  end
end
