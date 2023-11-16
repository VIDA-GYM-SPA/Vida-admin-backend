# == Route Map
#

# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :exchanges
  resources :roles
  resources :clients
  resources :users, except: [:profile, :edit_password]
  resources :payments

  get 'dashboard/status_card'
  get 'dashboard/invoices'

  get '/my-profile', to: "users#profile"
  
  put '/edit_password', to: "users#edit_password"
  post '/login', to: 'authentication#login'
  post '/rfid/write_order', to: 'application#write_order'

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
end
