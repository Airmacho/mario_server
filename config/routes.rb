Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # manipulate admin user autentication
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :admins
  resources :plumbers do
    get :jobs
  end
  resources :clients
  resources :jobs do 
    patch :complete
  end
end
