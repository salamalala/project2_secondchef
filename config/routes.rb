Rails.application.routes.draw do

  devise_for :users
  root "pages#about"

  get "/about", to: "pages#about"
  get "/help", to: "pages#help"
  get "/contact", to: "pages#contact"

end
