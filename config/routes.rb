Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations' 
  }
    
  devise_scope :user do
    delete 'delete_account', to: 'users/registrations#delete_account', as: 'delete_account'
    get 'show_profile', to: 'users/registrations#show_profile', as: 'show_profile'
  
  end

  root 'main#home'
end
