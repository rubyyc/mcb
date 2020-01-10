# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :students, controllers: {
      sessions: 'students/sessions',
      registrations: 'students/registrations',
      schedules: 'students/schedules',
      scheduled_students: 'students/scheduled_students'
  }
  devise_for :teachers, controllers: {
      sessions: 'teachers/sessions',
      registrations: 'teachers/registrations'
  }
  devise_scope :students do
    get 'students/sign_in', to:'students/sessions#new', as: :students_sign_in
    get 'students/sign_up', to:'students/registrations#new', as: :students_sign_up
    delete 'students/sign_out', to: 'students/sessions#destroy', as: :students_sign_out
    get 'students/forgot_password', to:'students/passwords#new', as: :students_forgot_password
    get 'students/reset_password', to:'students/password#edit', as: :students_reset_password
    get 'students/schedule', to:'pages#student_schedule', as: :students_schedule
    get 'students/new_schedule', to: 'students/scheduled_students#new', as: :new_scheduled_students
    post 'students/scheduled_student', to: 'students/scheduled_students#create', as: :create_scheduled_students
    delete 'students/scheduled_student', to: 'students/scheduled_students#destroy', as: :delete_scheduled_students
    get 'students/schedule/renew', to: 'students/schedules#renew', as: :renew_students_schedule
  end
  devise_scope :teachers do
    get 'teachers/sign_in', to:'teachers/sessions#new', as: :teachers_sign_in
    get 'teachers/sign_up', to:'teachers/registrations#new', as: :teachers_sign_up
    get 'teachers/forgot_password', to:'teachers/passwords#new', as: :teachers_forgot_password
    get 'teachers/reset_password', to:'teachers/password#edit', as: :teachers_reset_password
    get 'teachers/locations', to:'pages#teacher_locations', as: :teachers_locations
    get 'teachers/schedules', to:'pages#teacher_schedules', as: :teachers_schedules
    delete 'teachers/sign_out', to: 'teachers/sessions#destroy', as: :teachers_sign_out
  end
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  resources :locations, only: [:create, :destroy]

end
