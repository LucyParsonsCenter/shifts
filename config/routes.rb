Rails.application.routes.draw do
  resources :collective_members
  resources :trainees

  get '/' => 'static_pages#home'
end
