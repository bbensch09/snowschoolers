SnowSchoolers::Application.routes.draw do
  devise_for :users

  root :to => "lesson_times#new"

  resources :lesson_times
  resources :lessons
  resources :users

  put 'lessons/:id/set_instructor' => 'lessons#set_instructor', as: :set_instructor
end
