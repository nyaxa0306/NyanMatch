Rails.application.routes.draw do
  root "pages#home"

  get "favorites", to: "favorites#index", as: :favorite_cats

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :users, only: [:show, :update] do
    member do
      get "edit_profile"
      get "cats", to: "cats#user_cats"
    end
  end
  resources :cats do
    resource :favorite, only: [:create, :destroy]
  end
  resources :applications, only: [:index, :create] do
    member do
      patch :update_status
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
