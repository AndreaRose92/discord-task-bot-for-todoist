class ApplicationController < ActionController::API
  require_relative "../../config/auth.rb"
  require "rest_client"
  require "json"

  def api(endpoint, id = nil)
    "#{$todoist_api}/#{endpoint}/#{id}"
  end

  def get_request(endpoint, id = nil)
    JSON.parse(
      RestClient.get(
        api(endpoint, id), {
          "Authorization": "Bearer #{$todoist_token}",
        }
      )
    )
  end

  def post_request(endpoint, object)
    JSON.parse(
      RestClient.post(
        api(endpoint), object.to_json, {
          "Content-Type": "application/json",
          "Authorization": "Bearer #{$todoist_token}",
        },
      )
    )
  end

  def delete_request(endpoint, id)
    RestClient.delete(
      api(endpoint, id), {
        "Authorization": "Bearer #{$todoist_token}",
      }
    )
  end

  def reassign_priority(int)
    case int
    when 1
      return 4
    when 2
      return 3
    when 3
      return 2
    when 4
      return 1
    end
  end
end
