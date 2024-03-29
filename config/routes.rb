Rails.application.routes.draw do

  get 'payments/new'
  get 'subscription/new'
  root 'blog_pages#home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'customers/new'
  get 'help'    =>  'blog_pages#help'
  get 'favorites'    =>  'blog_pages#favorites'
  get 'about'   =>  'blog_pages#about'
  get 'contact' =>  'blog_pages#contact'
  get 'signup'  =>  'customers#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post 'blog_pages/group_message', to: 'blog_pages#group_message'
  post 'blog_pages/privat_message', to: 'blog_pages#privat_message'
  post 'blog_pages/send_message', to: 'blog_pages#send_message', as: 'send_message'
  get 'results', to: 'results#index', as: 'results'
  get 'search', to: 'results#index', as: 'search'
  get 'roomlist' => 'rooms#roomlist'
  get 'personal' => 'rooms#personal'
  get 'single_show/:id', to: 'rooms#single_show', as: 'single_show'
  get 'payment_method' => 'rooms#payment_method'

  resources :customers do
    member do
      get :following, :followers
    end
  end
  resource :blacklist, only: %i[show destroy] do
    resources :items, only: %i[create destroy]
  end
  resources :reviews
  resources :posts
  resources :rooms
  resources :microposts
  resources :telechannels
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :incoming_mails, only: [:create]

end
