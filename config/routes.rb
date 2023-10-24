Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'api/sessions',
    registrations: 'api/registrations'
  }
  namespace :api do
    resources :sessions, only: %i[index show update destroy]
    resources :messages, only: %i[index show update destroy]
  end
end
