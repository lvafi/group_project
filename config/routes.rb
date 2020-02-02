Rails.application.routes.draw do

  root 'users#new'

  resources :users , only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]


  resources :courses

  
  resources :rooms do
    resources :bookings
  end

  resources :courses do
    resources :enrollments
    resources :bookings
  end

end
