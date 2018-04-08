Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  resources :users, only: [:index] do
    resources :interviews, except: [:show,:update]
    put "interviews/:id", to: "interviews#update"
    patch "interviews/:id", to: "interviews#update_acceptance"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
