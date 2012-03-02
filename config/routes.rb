Cms::Engine.routes.draw do
  resources :pages do
    resources :widgets
  end
  resources :photos
  resources :events
  resources :forms do
    resources :form_records
  end
  resources :users do
    member do
      get :change_password
    end
  end
  resources :sessions, :only => [:create]
  resources :nav_menus do
    resources :nav_items
  end
  resources :people
  resources :categories
  resources :articles do
    resources :comments
  end
  
  match '/home', :to => 'admin#home', :as => :admin_home
  match '/signin', :to => 'sessions#new', :as => :signin
  match '/signout', :to => 'sessions#destroy', :as => :signout
  
  post '/order_widgets', :to => 'pages#order_widgets', :as => :order_widgets

  # Routes in the host application
  get '../categories/:id', :to => 'categories#show', :as => :host_category
  get '../articles/:id', :to => 'articles#show', :as => :host_article
  get '../pages/:id', :to => 'pages#show', :as => :host_page
  post 'form/:form_id/form_records', :to => 'form_records#create', :as => :create_form_record
  
  #match '../media/:file_name', :to => Dragonfly[:images]  
end

Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end
  
  # Routes in the host application
  get '/categories/:id', :to => 'categories#show', :as => :host_category
  get '/articles/:id', :to => 'articles#show', :as => :host_article  
  get '/pages/:id', :to => 'pages#show', :as => :host_page  
  post 'form/:form_id/form_records', :to => 'cms/form_records#create', :as => :create_form_record
  match '/media/:file_name', :to => Dragonfly[:images]  
end