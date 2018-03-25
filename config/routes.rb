Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  get '/interviews/new', to: 'interviews#new'
  post '/interviews/create', to: 'interviews#create'
  get '/interviews/edit/:id', to: 'interviews#edit'
  put '/interviews/update/:id', to: 'interviews#update'
  post '/interviews/delete/:id', to: 'interviews#delete'
  
  get '/interviews/:id', to: 'interviews#index'
  get '/interviews', to: 'interviews#index'
  resources :users, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
