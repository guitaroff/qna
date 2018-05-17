Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # concern позволяет выносить общие части в роутах и переиспользовать их
  concern :commentable do
    resources :comments
  end

  #concerns - подключил ресурс comments как вложенный
  resources :questions, concerns: :commentable do
    resources :answers
  end

  resources :answers, only: [], concerns: :commentable

  # api
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
    end
  end

  root to: "questions#index"
end
