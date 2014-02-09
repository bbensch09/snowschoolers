SnowSchoolers::Application.routes.draw do
  root to: "lesson_times#new"

  resources :lesson_times
  
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }

  resources :lessons
  put 'lessons/:id/set_instructor' => 'lessons#set_instructor', as: :set_instructor
end
