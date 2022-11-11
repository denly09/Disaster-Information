Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "posts#index"

  resources :posts do
    resources :comments, expect: :show
  end
  resources :categories

  get ':unique_num', to: 'posts#short_url'
end

