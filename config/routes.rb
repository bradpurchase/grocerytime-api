Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: {format: :json} do
    namespace :v2 do
      namespace :auth do
        resource :identity, only: :show, controller: :identity
        resource :login, only: :create, controller: :login
      end
    end
  end
end
