Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/auth/google_oauth2/callback', to: 'users#create'

  get '/', to: 'welcome#index'

  get '/dashboard', to: 'users#show'
  delete '/users', to: 'users#destroy'

  resources :items, only: [:new, :create]
  
  get '/foodbanks', to:'foodbanks#search'
  get '/foodbanks/index', to: 'foodbanks#index'
  get '/foodbanks/:id', to: 'foodbanks#show'

  get '/foodbanks/search', to:'foodbanks#search'

  get '/resources', to: 'resources#index'

  resources :recipes, only: [:show]
end
