Vacuum::Application.routes.draw do
  get "projects/index"

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
  resources :projects
  
  # Root the application
  root to: 'home#index'
end
