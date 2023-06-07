Rails.application.routes.draw do
  resources :tasks
  resources :projects

  get "/tasks/project/:project_name", to: "tasks#project_tasks"
  post "/tasks/:id/close", to: "tasks#close"
end
