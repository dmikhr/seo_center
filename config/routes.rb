require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'websites#new'

  resources :websites, only: %i[new create show] do
    resources :pages, only: %i[create show]
  end

end
