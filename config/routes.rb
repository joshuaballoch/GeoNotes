GeoNotes::Application.routes.draw do
  root :to => 'pages#home'
  resources :users
end
