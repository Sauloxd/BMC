Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :match_series

  get "/users/select_search" => "users#select_search"
  get "/users/selected_user_search" => "users#selected_user_search"
  
  resources :articles do
    resources :comments
  end
end
