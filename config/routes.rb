require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  root to: 'websites#new'

  resources :websites, only: %i[new create show] do
    resources :pages, shallow: true, only: %i[show] do
      post :parse, on: :member
    end
  end

end
