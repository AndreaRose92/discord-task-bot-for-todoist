Rails.application.routes.draw do
  resources :tasks
  resources :projects

  get "/tasks/:project_name", to: "tasks#project_tasks"
end
