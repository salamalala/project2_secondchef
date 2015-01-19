Rails.application.routes.draw do

  root "pages#about"

  get "/about", to: "pages#about"
  get "/help", to: "pages#help"
  get "/contact", to: "pages#contact"

end
