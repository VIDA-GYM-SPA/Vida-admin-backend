# == Route Map
#

# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  get 'payments/index'
  get 'users/index'
  get 'users/create'
  get 'users/edit'
  get 'users/destroy'
  
  post '/auth/login', to: 'authentication#login'
  post '/rfid/write_order', to: 'application#write_order'

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
end
