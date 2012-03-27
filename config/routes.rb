GeoNotes::Application.routes.draw do
  root :to => 'pages#home'
  match '/signout', :to => 'sessions#destroy'
  resources :notes
  resources :users
  resources :sessions
end
