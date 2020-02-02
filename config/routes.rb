Rails.application.routes.draw do

  root to: 'users#new'
  resources :users
  resource :session, only: [:new, :create, :destroy]
  
  resources :courses do
    resources :enrollments
  end

  resources :rooms do
    resources :bookings
  end
  
end
