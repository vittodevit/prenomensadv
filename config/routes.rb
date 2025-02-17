Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  devise_for :users, controllers: { registrations: "registrations" }

  # to make logout work with get request
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy", as: :destroy_user_session_via_get
  end

  get "user_list" => "user_list#index", as: :user_list
  delete "user_list/delete/:id", to: "user_list#delete", as: :delete_student
  post "user_list/approve/:id", to: "user_list#approve", as: :approve_student

  get "requests" => "request#index", as: :requests
  get "requests/new" => "request#new", as: :new_request
  post "requests" => "request#create", as: :create_request

  get "requests/:request_id/responses/new" => "response#new", as: :request_responses
  post "requests/:request_id/responses/new" => "response#create", as: :create_response

  get "requests/:request_id/" => "request#view", as: :view_responses
  delete "requests/delete/:request_id" => "request#delete", as: :delete_request

end
