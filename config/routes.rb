Rails.application.routes.draw do
  resources :users
  resources :short_urls, only: [:index, :create, :destroy]
  get 'shortify/:slug', to: 'short_urls#show', as: :short

  post '/auth/login', to: 'auth#login'
end
