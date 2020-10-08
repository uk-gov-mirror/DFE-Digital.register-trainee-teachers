require_relative "routes/sidekiq_routes"

Rails.application.routes.draw do
  extend SidekiqRoutes

  get :ping, controller: :heartbeat
  get :healthcheck, controller: :heartbeat

  get "/pages/:page", to: "pages#show"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  get "/trainees/not-supported-route", to: "trainees/not_supported_routes#index"

  resources :trainees, only: %i[index show new create update] do
    member do
      get "contact-details", to: "trainees/contact_details#edit"
      get "personal-details", to: "trainees/personal_details#edit"
      get "training-details", to: "trainees/training_details#edit"
      get "course-details", to: "trainees/course_details#edit"
    end
  end

  resources :trn_submissions, only: %i[create show]

  root to: "pages#show", defaults: { page: "start" }
end
