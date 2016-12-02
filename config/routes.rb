Rails.application.routes.draw do
  get 'users/overview', to: 'articles#users'

  get 'user/:id', to: 'articles#user', as: 'user'

  get 'articles/new'

  post 'articles/create'

  get 'articles/edit'

  patch 'articles/update'

  delete 'articles/destroy'

  post 'comments/create'

  devise_for :users

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
