Rails.application.routes.draw do
  root to: 'websites#new'

  resources :websites, only: %i[new create show]
end
