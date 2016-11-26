Rails.application.routes.draw do
  get 'users/index'

  get 'articles/index'

  get 'articles/user'

  get 'articles/new'

  post 'articles/create'

  get 'articles/edit'

  patch 'articles/update'

  delete 'articles/destroy'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
