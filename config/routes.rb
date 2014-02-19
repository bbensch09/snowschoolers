SnowSchoolers::Application.routes.draw do
  root to: "lessons#new"

  resources :lesson_times
  
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }

  resources :lessons
  put 'lessons/:id/set_instructor' => 'lessons#set_instructor', as: :set_instructor
  get 'lessons/:id/complete' => 'lessons#complete', as: :complete_lesson
end
