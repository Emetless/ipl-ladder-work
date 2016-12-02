Rails.application.routes.draw do
  get 'users', to: 'articles#users'

  get 'users/:id', to: 'articles#user'

  get 'articles/new'

  post 'articles/create'

  get 'articles/edit'

  patch 'articles/update'

  delete 'articles/destroy'

  devise_for :users

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
