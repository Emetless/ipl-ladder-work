Rails.application.routes.draw do
  get 'articles/index'

  get 'articles/user'

  get 'articles/new'

  post 'articles/create'

  get 'articles/edit'

  post 'articles/update'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
