# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: :index

      post '/users/:email/friendship', to: 'friendships#create', constraints: { email: /.+@.+\..*/ }
      get '/users/me/friends', to: 'friendships#index'

      post '/login', to: 'authentication#create'
      post '/signup', to: 'registration#create'
    end
  end
end
