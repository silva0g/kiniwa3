Rails.application.routes.draw do
  
  root 'pages#home'

  devise_for :users,
  			     path: '',
  			     path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
  			     controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  			 # On a ajouter registrations: 'registrations' pour appler la commande de Registrations_controller		

  resources :users, only: [:show] do 
    member do 
      post '/verify_phone_number' => 'users#verify_phone_number'
      patch '/update_phone_number' => 'users#update_phone_number'
    end
  end 

  resources :photos, only: [:create, :destroy]
  resources :menus, except: [:edit] do
  	member do
  		get 'listing'
  		get 'pricing'
  		get 'description'
  		get 'photo_upload'
  		get 'amenities'
  		get 'location'
      get 'preload'
      get 'preview'
      post 'add_product'
      get 'remove_product'
  	end
   
    resources :reservations, only: [:create]
    resources :calendars  
  end

   resources :products, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'preload'
      get 'preview'
    end
  end

  resources :chef_reviews, only: [:create, :destroy]
  resources :client_reviews, only: [:create, :destroy]

  get '/vos_commandes' => 'reservations#vos_commandes'
  get '/vos_prestations' => 'reservations#vos_prestations'

  
  get 'search' => 'pages#search'

  #------- Kinywa 3 --------
  get 'dashboard' => 'dashboards#index'
  
  resources :reservations, only: [:approve, :decline] do
    member do
      post '/approve' => "reservations#approve"
      post '/decline' => "reservations#decline"
    end
  end

  resources :revenues, only: [:index]

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  get '/chef_calendar' => "calendars#chef"
  get '/payment_method' => "users#payment"
  get '/payout_method' => "users#payout"
  post '/add_card' => "users#add_card"

  get '/notification_settings' => "settings#edit"
  post '/notification_settings' => "settings#update"

  get '/notifications' => 'notifications#index'

  # On rajout action cable pour gerer les notifications des messagérie...
  mount ActionCable.server => '/cable'

end
