# == Route Map
#

# frozen_string_literal: true

Rails.application.routes.draw do
  get 'payments/index'
  get 'users/index'
  get 'users/create'
  get 'users/edit'
  get 'users/destroy'

  post '/auth/login', to: 'authentication#login'

  mount ActionCable.server => '/cable'
end
