Rails.application.routes.draw do

  resources :users, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]

  resources :rooms do
    resources :bookings
  end

  resources :courses do
    resources :enrollments
  end

end
