Rails.application.routes.draw do

  # ------------
  # Public pages
  # ------------

  # root :to => 'public/user_sessions#sign_in'

  # Sign In URLs for users
  get     '/sign_in',         to: "public/user_sessions#sign_in",         as:  :sign_in
  post    '/create_session',  to: "public/user_sessions#create_session",  as:  :create_session

  # Logout Url
  delete  '/sign_out' ,       to: "public/user_sessions#sign_out",        as:  :sign_out

  # ------------
  # User pages
  # ------------

  namespace :users do
    get   '/dashboard',         to: "dashboard#index",  as:   :dashboard
    resources :users
    resources :questions
  end

  ##########
  root 'users#index'
  get 'users/check_email' => 'users#check_email'
  resources :users do
    member do
    get 'user_question'
    post "check_quiz"
    get "result"
    get "start"
  end
  end
  post 'admins/check_admin' => 'admins#check_admin'
  resources :admins do
    member do
      post 'individual_result'
      get 'all_result'
    end
  end
  resources :questions do
    resources :qchoices
  end

end
