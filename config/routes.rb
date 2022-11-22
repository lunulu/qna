Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :questions, shallow: true do
    resources :answers, only: %i[create update destroy]
  end

  post '/answers/:id', to: 'answers#mark_as_best', as: 'mark_as_best'
end
