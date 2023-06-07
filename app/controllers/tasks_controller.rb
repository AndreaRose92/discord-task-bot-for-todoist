class TasksController < ApplicationController
  def index
    tasks = get_request("tasks")
    tasks.each do |task|
      Task.find_or_create_by(external_id: task["id"]) do |new_task|
        new_task.update(parse_todoist_response(task))
      end
    end
    render json: tasks
  end

  def show
    task = get_request("tasks", Task.find_by(content: params["id"]).external_id)
    Task.find_or_create_by(external_id: task["id"]) do |new_task|
      new_task.update(parse_todoist_response(task))
    end
    render json: task
  end

  def create
    params["priority"] = reassign_priority(params["priority"].to_i)
    params["project_id"] = Project.find_by("name LIKE ?", "%#{params["project"]}%").external_id
    task = post_request("tasks", params)
    Task.create(parse_todoist_response(task))
    render json: task
  end

  def project_tasks
    tasks = JSON.parse(
      RestClient.get(
        "#{$todoist_api}/tasks?project_id=#{Project.where("name LIKE ?", "%#{params["project_name"]}%").first.external_id}", {
          "Authorization": "Bearer #{$todoist_token}",
        }
      )
    )
    tasks.each do |task|
      Task.find_or_create_by(external_id: task["id"]) do |new_task|
        new_task.update(parse_todoist_response(task))
      end
    end
    render json: tasks
  end

  def close
    task = Task.find_by(content: params["id"])
    task.destroy
    response = JSON.parse(
      RestClient.post(
        "#{$todoist_api}/tasks/#{task.external_id}/close", {
          "Content-Type": "application/json",
          "Authorization": "Bearer #{$todoist_token}",
        }
      )
    )
    head :no_content
  end

  private

  def parse_todoist_response(object)
    project = Project.where("name LIKE ?", "%#{params["project"]}%").first
    task = {
      project: project,
      external_id: object["id"],
      external_project_id: object["project_id"],
      section_id: object["section_id"],
      content: object["content"],
      description: object["description"],
      is_completed: object["is_completed"],
      labels: object["labels"],
      parent_id: object["parent_id"],
      order: object["order"],
      priority: reassign_priority(object["priority"]),
      url: object["url"],
      comment_count: object["comment_count"],
    }
  end
end
