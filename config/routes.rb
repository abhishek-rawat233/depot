Rails.application.routes.draw do
  get 'admin' => 'admin#index'


  scope '/admin' do
    get '/reports', to: 'reports#index'
    get '/categories', to: 'admin#show_categories'
    get '/categories/:id/books', to: redirect("") if :id.match /[0-9]*/
    get '/categories/:id/books', to: 'admin#show_products', as: 'categories_products'
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :users do
    get :'/my-orders', to: "users#orders", as: 'orders'
    get :'/my-items', to: "users#lineItems", as: 'line_items'
  end

  resources :products, path: :books, as: :products
    resources :products do
      get :who_bought, on: :member
    end

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
end
