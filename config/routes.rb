Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # manipulate admin user autentication
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :plumbers, only: [:create] do
    get :jobs
  end
  resources :clients, only: [:create, :destroy]
  resources :jobs, only: [:index, :create, :destroy] do 
    patch :complete
  end
end
