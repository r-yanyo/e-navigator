Rails.application.routes.draw do
  root 'users#index'

  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  resources :users, only: [:index] do
    post "/notify", to: "users#notify", as: "notify"
    resources :interviews
    put "interviews/:id/accept", to: "interviews#update_acceptance", as: "interview_accept"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
