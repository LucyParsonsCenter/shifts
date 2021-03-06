Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations" }
  root to: 'static_pages#home'

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :events
  resources :collective_members

  get '/' => 'static_pages#home'
  get '/home' => 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  get '/normal_shifts' => 'events#normal_shifts'
  get '/training_shifts' => 'events#training_shifts'
  get '/meetings_feed' => 'events#meetings'
  get '/events_feed' => 'events#events'
  post '/create_or_update_event' => 'events#create_or_update'
end
