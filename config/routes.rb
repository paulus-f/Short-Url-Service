Rails.application.routes.draw do
  resources :users
  resources :short_urls, only: %i[index create destroy]

  get 'metrics/:slug', to: 'metrics#show'
  get 'most_viewed', to: 'metrics#most_viewed'
  get 'shortify/:slug', to: 'short_urls#show'

  post '/auth/login', to: 'auth#login'
end
