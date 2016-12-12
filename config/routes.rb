Rails.application.routes.draw do
  get 'users/overview', to: 'articles#users'

  get 'user/:id', to: 'articles#user', as: 'user'

  get 'articles/new'

  post 'articles/create'

  get 'articles/edit'

  patch 'articles/update'

  delete 'articles/destroy'

  post 'comments/create'

  delete 'comments/destroy'

  devise_for :users, controllers: { sessions: 'over_sessions', registrations: 'over_registrations' }

  root 'articles#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
