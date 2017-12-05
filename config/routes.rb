Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :restaurants, only: [ :show ]
      resources :users, only: [ :create ]
      post 'shake', to: 'shakes#shake'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
