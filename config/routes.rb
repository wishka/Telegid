Rails.application.routes.draw do


  get 'password_resets/new'
  get 'password_resets/edit'
  get 'customers/new'
  root 'blog_pages#home'
  get 'help'    =>  'blog_pages#help'
  get 'about'   =>  'blog_pages#about'
  get 'contact' =>  'blog_pages#contact'
  get 'signup'  =>  'customers#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post 'blog_pages/group_message', to: 'blog_pages#group_message'
  post 'blog_pages/privat_message', to: 'blog_pages#privat_message'
  post 'blog_pages/send_message', to: 'blog_pages#send_message', as: 'send_message'
  get "search", to: "search#search"
  get 'search/typeahead/:term' => 'search#typeahead'

  resources :customers
  resources :posts
  resources :rooms

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
