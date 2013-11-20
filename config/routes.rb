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
      get :following, :followers, :venues, :microposts, :feed, :feedtender, :feedpopular, :valid, :search, :searchemail
    end
    #resources :venues, only: [:create, :destroy]
  end

  #########################################
  # related models
  #########################################
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy, :show]
  resources :tokens,:only => [:create, :destroy]

  #########################################
  # the venues
  #########################################
  resources :venues, only: [:index, :create] do 
    # added POSTs for all these so we can update info on venues
    member do
      post :favorite, :unfavorite
      get :feed
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
