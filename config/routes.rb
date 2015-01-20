Rails.application.routes.draw do

  root "meals#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users, only: [:show, :edit, :update]
  resources :meals do
    resources :orders, only: [:new, :create]
  end
  resources :orders, only: [:index, :show]
  resources :reviews, only: [:new, :create, :edit, :update, :destroy]


  get "/about", to: "pages#about"
  get "/help", to: "pages#help"
  get "/contact", to: "pages#contact"

end
