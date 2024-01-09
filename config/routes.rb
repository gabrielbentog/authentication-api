Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      post '/authenticate', to: 'authenticate#authenticate_user'

      resources :users
    end
  end
end
