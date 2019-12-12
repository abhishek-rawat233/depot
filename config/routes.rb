Rails.application.routes.draw do

  get 'admin' => 'admin#index'

  scope '/admin' do
    get '/reports', to: 'reports#index'
    get '/categories', to: 'admin#show_categories'
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get 'sessions/create'
  get 'sessions/destroy'

  get 'category' => 'category#index'

  # resources :wsers
  resources :users do
    get :orders, to: "users#orders"
    get :line_items, to: "users#lineItems"
  end
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
  # get 'store/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
