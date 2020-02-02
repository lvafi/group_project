Rails.application.routes.draw do

  root 'users#new'

  resources :users , only: [:new, :create, :edit, :update, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :rooms do
    resources :bookings
  end

  resources :courses do
    resources :enrollments
  end

end
