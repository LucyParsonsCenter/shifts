Rails.application.routes.draw do
  resources :trainees

  get '/' => 'static_pages#home'
end
