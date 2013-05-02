Vacuum::Application.routes.draw do
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

  # Standard Resourcing
  resources :projects do
    resources :errors do
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
    mount ErrorPreview => 'error_mail'
    mount UserPreview => 'user_mail'
  end

  # Root the application
  authenticated :user do
    root :to => "projects#index"
  end
  root to: 'home#index'
end