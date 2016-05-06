Rails.application.routes.draw do


 root 'ditzy#index'
 get 'dashboard/:id' => 'users#show', :as => 'dashboard'

 get '/users/:user_id/products' => 'users#show_by_merchant', as: "user_products"
  # get '/account' => 'users'

  resources :catagory

  resources :sessions, :only => [:new, :create, :destroy]
  delete '/logout' => 'sessions#destroy'

  resources :billings
  
  resources :users, :only => [:new, :create] do
    # resources :products (commented out to write what's needed by hand)
    resources :orders
  end


  resources :orders do 
    resources :orderitems
    resources :users
  end

  resources :products do
    resources :reviews
    resources :orders
  end

  # resources :reviews do
  #   resources :users
  #   resources :products
  # end
end
