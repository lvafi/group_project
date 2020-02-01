Rails.application.routes.draw do

  root 'users#new'

  resources :users, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]


end
