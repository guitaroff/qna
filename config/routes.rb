Rails.application.routes.draw do
  devise_for :users

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable do
    resources :answers
  end

  resources :answers, only: [], concerns: :commentable

  root to: "questions#index"
end
