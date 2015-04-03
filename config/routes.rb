Rails.application.routes.draw do

  # ------------
  # Public pages
  # ------------

  root :to => 'public/user_sessions#sign_in'

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
    #get   '/profile',           to: "profile#index",    as:   :profile
    #get   '/edit',              to: "profile#edit",     as:   :edit
    #put   '/update',            to: "profile#update",   as:   :update

    resources :users
    resources :questions

    # resources :images do
    #   member do
    #     put :crop
    #   end
    # end
  end

  ##########
  #root 'users#index'
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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
