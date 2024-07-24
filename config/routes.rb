Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      get "up" => "rails/health#show", as: :rails_health_check

      post "authenticate" =>"authenticate#authenticate"
      resources :users
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
