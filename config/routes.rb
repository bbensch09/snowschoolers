SnowSchoolers::Application.routes.draw do
  resources :beta_users

  root to: "lessons#new"

  resources :lesson_times

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }

  resources :lessons
  put   'lessons/:id/set_instructor'      => 'lessons#set_instructor',      as: :set_instructor
  put   'lessons/:id/remove_instructor'   => 'lessons#remove_instructor',   as: :remove_instructor
  patch 'lessons/:id/confirm_lesson_time' => 'lessons#confirm_lesson_time', as: :confirm_lesson_time
  get   'lessons/:id/complete'            => 'lessons#complete',            as: :complete_lesson
end
