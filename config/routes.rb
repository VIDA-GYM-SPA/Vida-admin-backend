# == Route Map
#

# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :clients
  get 'dashboard/status_card'
  get 'dashboard/invoices'
  resources :users, except: [:profile]

  get '/my-profile', to: "users#profile"
  
  post '/auth/login', to: 'authentication#login'
  post '/rfid/write_order', to: 'application#write_order'

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
end
