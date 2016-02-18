Rails3BootstrapDeviseCancan::Application.routes.draw do

  #########################################
  # If you are logged in or not logged in you still go to the home page, but you could go to different places
  #########################################
  root :to => "home#index"


  #########################################
  # the routes for user stuff etc are somewhere else because we are using devise
  # although this line overrides the registrations because we wanted to customize
  #########################################
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
  controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}
  
  #########################################
  # the users
  #########################################
  resources :users, only: [:index, :create, :show, :update, :destroy]  do
    # added GETs for all these to customize data we get about a user
    member do
      get :following, :following_count, :searchfollowing, :followers, :followers_count, :searchfollowers, :recentfollowers, :friendrequests, :myrelationship, :myreverserelationship, :venues, :microposts, :microposts_count, :feed, :feedtender, :feedpopular, :feedlocal, :valid, :search
    end
    member do
      post :searchemail, :invitationemailonly, :refreshnotify, :blockuser
    end
  end

  #########################################
  # user related models
  #########################################
  resources :microposts, only: [:create, :destroy, :show] do
    member do
      post :taguser
    end
  end
  resources :checkins, only: [:create, :destroy] do

  end
  resources :likes, only: [:create, :destroy] do
    
  end
  resources :comments, only: [:create, :destroy] do
    
  end
  resources :tokens,:only => [:create, :destroy]
  resources :relationships, only: [:create, :destroy] do
    member do
      post :updatestatus, :confirmfollow
    end
  end
  resources :locations, only: [:index, :create, :show] do
    
  end
  resources :devices, only: [:create, :destroy] do
    
  end

  #########################################
  # the venues
  #########################################
  resources :venues, only: [:index, :create] do 
    collection do
      post :venuesfromarray
    end
    member do
      post :favorite, :unfavorite, :workfavorite, :workunfavorite
      get :feed, :workerfeed
    end
  end
  resources :shifts, only: [:index, :create, :destroy] do 

  end

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
      post :favorite, :unfavorite, :tagdrink, :untagdrink, :updatephoto
    end
  end
  resources :categories, only: [:index, :create, :show] do 
    collection do
      get :search, :feedpopular
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
  match 'privacy' => 'static_pages#privacy', :as => 'privacy', :via => :get
  match 'list/subscribe' => 'static_pages#subscribe', :as => 'subscribe', :via => :get
  match 'list/unsubscribe' => 'static_pages#unsubscribe', :as => 'unsubscribe', :via => :get
  match 'list/confirmed' => 'static_pages#confirmed', :as => 'confirmed', :via => :get
end
