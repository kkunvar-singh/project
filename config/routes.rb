Rails.application.routes.draw do
  root "home#index"
  resources :forget_passwords, only: [:index, :create]
  resources :verify_otps, only: [:index] do
    collection do
      post 'verify_user_otp'
      get 'new_password'
      post 'verify_user_forget_password'
    end
  end

  resources :sessions, only: [:new, :create] do
    collection do
      delete 'destroy', as: :destroy_session
    end
  end
  resources :users
  get '/search', to: "users#search"
  resources :educations
end
