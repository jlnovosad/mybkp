Rails3BootstrapDeviseCancan::Application.routes.draw do

  #########################################
  # If you are logged in or not logged in you still go to the home page, but you could go to different places
  #########################################
  root :to => "home#index"


  #########################################
  # the routes for user stuff etc are somewhere else because we are using devise
  # although this line overrides the registrations because we wanted to customize
  #########################################
  devise_for :users, :controllers => { :registrations => "registrations" }
  

  #########################################
  # the users
  #########################################
  resources :users do
    # added GETs for all these to customize data we get about a user
    member do
      get :following, :following_count, :followers, :followers_count, :myrelationship, :venues, :microposts, :feed, :feedtender, :feedpopular, :valid, :search
    end
    member do
      post :searchemail, :invitationemailonly
    end
  end

  #########################################
  # user related models
  #########################################
  resources :microposts, only: [:create, :destroy]
  resources :tokens,:only => [:create, :destroy]
  resources :relationships, only: [:create, :destroy, :show] do
    member do
      post :updatestatus
    end
  end

  #########################################
  # the venues
  #########################################
  resources :venues, only: [:index, :create] do 
    member do
      get :feed
    end
  end

  #########################################
  # venue related models
  #########################################
  resources :favorites, only: [:create, :destroy] 
  resources :workfavorites, only: [:create, :destroy] 

  #########################################
  # the drinks
  #########################################
  resources :drinks, only: [:index, :create, :show] do 
    collection do
      get :search, :feedpopular
    end
    member do
      get :drinkusers
    end
    member do
      post :favorite, :unfavorite
    end
  end
  resources :categories, only: [:index, :create, :show] do 
    collection do
      get :search, :feedpopular
    end
    member do
      post :tagdrink, :untagdrink
    end
  end
  resources :styles, only: [:index, :show] do 
    member do
      post :taguser, :untaguser
    end
  end

  #########################################
  # email forms
  #########################################
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contactsend', :via => :post
  #match 'invite' => 'invite#create', :as => 'invite', :via => :post
  
  #########################################
  # match defines a url directly 
  # these are the static pages
  #########################################
  match 'list/subscribe' => 'static_pages#subscribe', :as => 'subscribe', :via => :get
  match 'list/unsubscribe' => 'static_pages#unsubscribe', :as => 'unsubscribe', :via => :get
  match 'list/confirmed' => 'static_pages#confirmed', :as => 'confirmed', :via => :get
end
