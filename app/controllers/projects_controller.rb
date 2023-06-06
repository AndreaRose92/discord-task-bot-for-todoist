class ProjectsController < ApplicationController
  def index
    projects = get_request("projects")
    projects.each do |project|
      Project.find_or_create_by(name: project["name"]) do |new_project|
        new_project.update(parse_todoist_response(project))
      end
    end
    render json: projects
  end

  def show
    projects = get_request("projects")
    target_index = projects.index { |project| project["name"].include? params[:id] }
    # project = get_request("projects", projects[target_index]["id"])
    render json: projects[target_index]
  end

  def create
    project = post_request("projects", params)
    Project.create(parse_todoist_response(project))
    render json: project
  end

  def destroy
    project = Project.where("name LIKE ?", "%#{params[:id]}%").first
    project.destroy
    delete_request("projects", project.external_id)
  end

  private

  def parse_todoist_response(object)
    project = {
      name: object["name"],
      external_id: object["id"],
      comment_count: object["comment_count"],
      color: object["color"],
      is_shared: object["is_shared"],
      order: object["order"],
      is_favorite: object["is_favorite"],
      is_inbox_project: object["is_inbox_project"],
      is_team_inbox: object["is_team_inbox"],
      view_style: object["view_style"],
      url: object["url"],
      parent_id: object["parent_id"],

    }
  end
end
