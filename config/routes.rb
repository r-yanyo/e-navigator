Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  resources :users, only: [:index] do
    post "/apply", to: "users#apply", as: "apply"
    resources :interviews
    put "interviews/:id/accept", to: "interviews#update_acceptance", as: "interview_accept"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
