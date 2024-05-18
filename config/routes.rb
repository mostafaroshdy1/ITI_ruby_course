Rails.application.routes.draw do
  root "articles#index"
  resources :articles do
    resources :comments
    member do
      patch :report
    end
  end

  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
