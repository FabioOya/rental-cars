Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :manufacturers
  resources :customers do
    get 'search', on: :collection
  end
  resources :car_categories
  resources :subsidiaries
  resources :car_models, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :new, :create] do
    get 'search', on: :collection
  end
end
