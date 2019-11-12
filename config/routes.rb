require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'websites#new'

  resources :websites, only: %i[index new create destroy show] do
    delete :destroy_all_versions, on: :member
    resources :pages, shallow: true, only: %i[show] do
      post :parse, on: :member
    end
  end

  namespace :admin do
    resources :users, only: %i[index]
  end

end
