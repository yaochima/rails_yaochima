Rails.application.routes.draw do
  # devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :restaurants, only: [ :show ]
      resources :guests, only: [ :create ]
      resources :shakes, only: [ :create ]
    end
  end

  get "/" => "pages#landing"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
