Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations" }
  root to: 'static_pages#home'

  resources :events
  resources :collective_members

  # static pages
  get '/' => 'static_pages#home'
  get '/home' => 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'

  # API for fullcalendar
  get '/normal_shifts' => 'events#normal_shifts'
  get '/training_shifts' => 'events#training_shifts'
  get '/meetings_feed' => 'events#meetings'
  get '/events_feed' => 'events#events'
  post '/create_or_update_event' => 'events#create_or_update'

  # admin pages
end
