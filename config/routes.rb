Rails.application.routes.draw do

  root 'members#show'
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
              }

  #users routes
  namespace :users do
    resources :users ,only: [:index, :create, :update]
  end 

# books routes
  namespace :book do
    resources :books, path: '/'
  end

  resources :issuedbooks, controller: "book/issuedbooks"
  # get '/member-data', to: 'members#show'

  
end