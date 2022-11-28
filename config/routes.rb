Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :questions, shallow: true do
    resources :answers, only: %i[create update destroy]
  end

  post '/answers/:id', to: 'answers#mark_as_best', as: 'mark_as_best'

  delete '/answers/:id/files/:file_id', to: 'answers#delete_file', as: 'answer_delete_file'
  delete '/questions/:id/files/:file_id', to: 'questions#delete_file', as: 'question_delete_file'
end
