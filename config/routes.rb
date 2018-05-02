Rails.application.routes.draw do
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

  root to: "questions#index"
end
