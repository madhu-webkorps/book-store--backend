Rails.application.routes.draw do

   # This will generate devise routes
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
#users routes
  namespace :users do
    resources :users ,only: [:index, :create]
  end 

  # books routes
  namespace :book do
    resources :books, path: '/'
  end

    get '/member-data', to: 'members#show'

end