require 'sidekiq/web'

Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, path: '', 
              path_names:  { sign_in: :login, sign_out: :logout, sign_up: :register },
              controllers: { 
                omniauth_callbacks: 'users/omniauth_callbacks',
                sessions: 'devise/sessions',
                registrations: 'devise/registrations'
                # registrations: "users/registrations"
              }
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # mount Rswag::Ui::Engine => '/api-docs'
  # mount Rswag::Api::Engine => '/api-docs'
  resources :items
  resources :likes
  resources :folders
  resources :partners
  resources :links
  resources :industries
  resources :categories
  resources :users
  resources :browse_histories
  resources :download_histories
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # authenticate :admin_user, lambda { |u| u.class.name == "AdminUser" } do
  #   mount Sidekiq::Web => '/sidekiq'
  #   mount PgHero::Engine, at: "pghero"
  # end
  
  namespace :admin do
    resources :partners
    resources :links
    resources :categories
    resources :industries
    resources :items
    resources :users
    resources :browse_histories
    resources :download_histories
    resources :likes

    root to: "items#index"
  end
end
