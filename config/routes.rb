Rails.application.routes.draw do
  get 'articles/index'

  get 'articles/edit'

  post 'new_article', to: 'articles#new'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
