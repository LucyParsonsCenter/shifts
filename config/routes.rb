Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :collective_members
  resources :trainees
  resources :shifts

  get '/' => 'static_pages#home'
  get '/home' => 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  get '/normal_shifts' => 'shifts#normal_shifts'
  get '/training_shifts' => 'shifts#training_shifts'
  get '/meetings' => 'shifts#meetings'
end
