Rails.application.routes.draw do
  root 'summoners#index'

  resources :summoners, only: [:index, :show] do
    resources :match, only: :show, controller: 'matches'
  end
end
