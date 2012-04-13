Cms::Engine.routes.draw do
  scope '(groups/:group_id)' do
    resources :pages do
      resources :widgets
      collection do
        post :layout, :add_row, :split_panel, :update_row
      end
    end
    resources :photos
    resources :events
    resources :forms do
      resources :form_records
    end
    resources :nav_menus do
      resources :nav_items
    end
    resources :people
    resources :documents
    resources :articles do
      resources :comments
    end
    resources :categories    
  end
  
  resources :regions do
    resources :panels
  end
  resources :widgets
  
  resources :users do
    member do
      get :change_password
    end
  end
  resources :sessions, :only => [:create]
  resources :groups
  
  resources :site do
    collection do
      get :edit
      post :update
    end
  end
  
  match '/', :to => 'admin#home', :as => :cms
  match '/home', :to => 'admin#home', :as => :admin_home
  match '/signin', :to => 'sessions#new', :as => :signin
  match '/signout', :to => 'sessions#destroy', :as => :signout
  
  post '/order_widgets', :to => 'pages#order_widgets', :as => :order_widgets

  # Routes in the host application
  get '../categories/:id', :to => 'categories#show', :as => :host_category
  get '../articles/:id', :to => 'articles#show', :as => :host_article
  get '../pages/:id', :to => 'pages#show', :as => :host_page
  get '../events/:id', :to => 'events#show', :as => :host_event  
  post 'form/:form_id/form_records', :to => 'form_records#create', :as => :create_form_record
  match '../articles/(groups/:group_id)/(categories/:category_id)', :to => 'articles#index', :as => :group_category_articles
  
  match '../media/:file_name', :to => Dragonfly[:images]  
end

Rails.application.routes.draw do
  
  resources :articles do
    resources :comments
  end
  match '/articles/(groups/:group_id)/(categories/:category_id)', :to => 'articles#index', :as => :group_category_articles
  
  # Routes in the host application
  get '/categories/:id', :to => 'categories#show', :as => :host_category
  get '/articles/:id', :to => 'articles#show', :as => :host_article  
  get '/pages/:id', :to => 'pages#show', :as => :host_page  
  get '/events/:id', :to => 'events#show', :as => :host_event
  post 'form/:form_id/form_records', :to => 'cms/form_records#create', :as => :create_form_record
  match '/media/:file_name', :to => Dragonfly[:images]
  match '/', :to => 'pages#home', :as => :root
  match '/:id', :to => 'pages#group_homepage', :as => :group_homepage
end