Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
             namespace :users do
              resources :users ,only: [:index, :create]
             end      
  get '/member-data', to: 'members#show'
end