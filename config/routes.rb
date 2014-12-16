Rails.application.routes.draw do
  root to: 'metrics#index'

  resources :metrics
end
