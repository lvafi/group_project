Rails.application.routes.draw do

  root to: 'users#show'
  resources :users
  resource :session, only: [:new, :create, :destroy]
  
  resources :courses do
    resources :enrollments
    get :enrolled_courses, on: :collection
  end

  resources :rooms do
    resources :bookings do
      put :approving
      put :rejecting 
    end
  end
  
end
