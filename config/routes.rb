Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'api/sessions',
    registrations: 'api/registrations'
  }
  delete '/api/users', to: 'api/registrations#destroy'
end
