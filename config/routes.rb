Rails.application.routes.draw do
  root 'dogs#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Dogs route
  resources :dogs, only: [:index, :show]

  # Owners route
  resources :owners, only: [:index, :show]

  # Locations route
  resources :locations, only: [:index, :show]

  # About route
  resources :about, only: [:index]
end
