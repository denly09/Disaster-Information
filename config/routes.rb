Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "posts#index"

  resources :posts, path_names: { new: '1234', edit: '4321' } do
    scope(path_names: { new: '5897', edit: '9752' }) do
      resources :comments, path: '4854', expect: :show
      end
  end
  resources :categories

end

