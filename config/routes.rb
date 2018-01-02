Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  # scope "(:locale)", locale:/en|ar/ do
  scope "(:locale)", locale:/#{I18n.available_locales.join("|")}/ do

  resources :comments
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  resources :messages
  resources :users, param: :username
  resources :categories, param: :name
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :follows,       only: [:create, :destroy]
  resources :categories
  resources :users do
    resources :messages
    member do
      get :following, :followers, :followersCat
    end
  end
  resources :categories do
     member do
      get :following
    end
  end

   resources :links, param: :title do
    collection do
      get 'search'
    end
      member do
        put "like", to:    "links#upvote"
        put "dislike", to: "links#downvote"
        put "notLogin", to:    "links#vote_notLogin"
        
      end
    resources :comments do
      member do
        put "like", to:    "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
    end
  end
 
 # match "/404", :to => "errors#not_found"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'pages#welcome', as: 'home'
  # root :to => "pages#welcome"
  root 'links#index', as: 'home'
  root :to => "links#index"

   # example of regular Route.
  get 'about' => 'pages#about', as: 'about'
  get 'welcome' => 'pages#welcome', as: 'welcome'
  get '/signup', to: 'users#new' 
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

match "/404", :to => "errors#not_found", :via => :all
match "/500", :to => "errors#internal_server_error", :via => :all

  
end


# at the end of you routes.rb
# match '*a', :to => 'errors#routing', via: :get
# get '*unmatched_route', to: 'application#not_found'
 
end

