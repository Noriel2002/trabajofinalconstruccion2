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
    resources :links do
      collection do
        get 'new_private_link'
        post 'create_private_link'
      end
    end
  end  
  

  resources :users do
    resources :links, only: [:index] # Esta línea define una ruta para mostrar los enlaces del usuario
  end
  
  get '/access_link/:slug', to: 'links/links#access_link', as: 'access_link'
  get 'links/:slug/access_details', to: 'links/links#access_details', as: 'access_details_links'
  get 'links/:slug/access_count_by_day', to: 'links/links#access_count_by_day', as: 'access_count_by_day_links'
  get '/public_links', to: 'links/links#public_index', as: 'public_links'
  
  post '/links/:slug/authenticate_private_link', to: 'links/links#authenticate_private_link', as: 'authenticate_private_link'
  
  get 'l/:slug', to: 'links/links#access_link'

  root to: 'links/links#index'
end
