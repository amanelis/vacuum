Vacuum::Application.routes.draw do
  get "projects/index"

  # Devise model mapping
  devise_for :users
  
  # Devise scoped routes
  devise_scope :user do
    get '/account'       => 'devise/registrations#edit',  as: 'account'
    get '/login'         => 'devise/sessions#new',        as: 'login'
    get '/logout'        => 'devise/sessions#destroy',    as: 'logout'
    get '/signup'        => 'devise/registrations#new',   as: 'signup'
    get '/forgot'        => 'devise/passwords#new',       as: 'forgot_password'
  end

  # Standard Resourcing
  resources :projects
  
  # Root the application
  root to: 'home#index'
end
