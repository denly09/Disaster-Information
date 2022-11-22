Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "posts#index"

  resources :posts do
    resources :comments, expect: :show
  end
  resources :categories
  namespace :admin do
    resources :users
  end
  namespace :api do
    resources :regions, only: :index, defaults: { format: :json } do
      resources :provinces, only: :index, defaults: { format: :json } do
        resources :city_municipalities, only: :index, defaults: {format: :json} do
          resources :barangays, only: :index, defaults: {format: :json}
        end
      end
      resources :districts, only: :index, defaults: { format: :json } do
        resources :city_municipalities, only: :index, defaults: {format: :json} do
          resources :barangays, only: :index, defaults: {format: :json}
        end
      end
    end
  end

  get ':unique_num', to: 'posts#short_url'
end

