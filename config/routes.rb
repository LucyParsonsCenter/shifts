Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :collective_members
  resources :trainees

  get '/' => 'static_pages#home'
  get '/home' => 'static_pages#home'
end
