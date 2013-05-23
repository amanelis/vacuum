Vacuum::Application.routes.draw do
  # DJ Monitor
  match "/dj" => DelayedJobWeb, :anchor => false

  # API Routes
  namespace :api do
    namespace :v1 do
      resources :errors
      resources :projects
    end
  end

  # Devise model mapping
  devise_for :users,
    :controllers => {
      :confirmations      => 'user/confirmations',
      :omniauth_callbacks => 'user/omniauth_callbacks',
      :passwords          => 'user/passwords',
      :registrations      => 'user/registrations',
      :sessions           => 'user/sessions',
      :unlocks            => 'user/unlocks'
  }

  # Devise scoped routes
  devise_scope :user do
    get '/account'       => 'user/registrations#edit',  as: 'account'
    get '/login'         => 'user/sessions#new',        as: 'login'
    get '/logout'        => 'user/sessions#destroy',    as: 'logout'
    get '/signup'        => 'user/registrations#new',   as: 'signup'
    get '/forgot'        => 'user/passwords#new',       as: 'forgot_password'
  end

  # Static pages
  get '/pricing'        => 'pages#pricing',             as: 'pricing'

  # Standard Resourcing
  resources :billing
  resources :projects do
    resources :errors do
      collection do
        post :group_resolve
      end
      member do
        get :resolve
      end
    end
    resources :collaborators
    resources :notifications
  end

  # Development specific testing routes
  if Rails.env.development?
    match '/logger/:id/err'   => 'home#errors', :via => [:get, :post]
    match '/logger'           => 'home#errors', :via => [:get, :post]

    # Preview all emails with routes like followed
    mount AdminPreview  => 'admin_mail'
    mount ErrorPreview  => 'error_mail'
    mount UserPreview   => 'user_mail'
  end

  # Root the application
  authenticated :user do
    root :to => "projects#index"
  end

  root to: 'home#index'
end