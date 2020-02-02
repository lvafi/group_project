Rails.application.routes.draw do

  root to: 'users#new'
  
  resources :courses do
    resources :enrollments
  end

  resources :rooms do
    resources :bookings
  end

  resources :users
  resource :session, only: [:new, :create, :destroy]
  
end
