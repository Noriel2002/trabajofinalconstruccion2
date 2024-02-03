Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations' 
  }
    
  devise_scope :user do
    delete 'delete_account', to: 'users/registrations#delete_account', as: 'delete_account'
    get 'show_profile', to: 'users/registrations#show_profile', as: 'show_profile'
  
  end

   namespace :links do
    resources :links
  end

  resources :users do
    resources :links, only: [:index] # Esta línea define una ruta para mostrar los enlaces del usuario
  end
  
  get '/l/:slug', to: 'links#access_link'
  
  root 'main#home'
end
