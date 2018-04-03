Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  resources :users, only: [:index] do
    resources :interviews
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
