Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root "home#index"

  resources :clubs, shallow: true do 
    resources :match_series do 
      resources :matches
    end
  end

  get "/users/select_search" => "users#select_search"
  get "/users/selected_user_search" => "users#selected_user_search"

end
