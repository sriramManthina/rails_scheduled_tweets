Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"



  # my changes start here ____________________________
  root "main#index" # view home page

  # GET /about (goes to about controller, index action)
  get "about_us", to: "about#index", as: :about # view about us page

  get "password", to: "passwords#edit", as: :edit_password # form for editing password
  patch "password", to: "passwords#update" # form handler for editing password

  get "password/reset", to: "password_resets#new" # form for sending reset mail
  post "password/reset", to: "password_resets#create" # form handler for sending reset mail
  get "password/reset/edit", to: "password_resets#edit" # form for new password
  patch "password/reset/edit", to: "password_resets#update" # form handler to update the password

  get "sign_up", to: "registrations#new" # form for creating new user
  post "sign_up", to: "registrations#create" # form handler for creating new user

  get "sign_in", to: "sessions#new" # form for logging in user
  post "sign_in", to: "sessions#create" # form handler for logging in user

  delete "logout", to: "sessions#destroy" # logout user by removing session token
end
