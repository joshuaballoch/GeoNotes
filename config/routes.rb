GeoNotes::Application.routes.draw do
  root :to => 'pages#home'
  match '/signout', :to => 'sessions#destroy'
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'
  
  resources :notes
  resources :users
  resources :sessions
end
