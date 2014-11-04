Rails.application.routes.draw do
    resources :users, only: [:new, :create, :index, :show] do
    resources :goals, only: [:new, :create]
  end
  resources :goals, except: [:new, :create] do
    post 'toggle_privacy', on: :member
    post 'toggle_completion', on: :member
  end
  resource :session, only: [:new, :create, :destroy]
end
