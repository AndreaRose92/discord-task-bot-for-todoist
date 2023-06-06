class ApplicationController < ActionController::API
  require_relative "../../config/auth.rb"
  require "rest_client"
  require "json"

  def api(endpoint, id = nil)
    "#{$todoist_api}/#{endpoint}/#{id}"
  end

  def get_request(endpoint, id = nil)
    JSON.parse RestClient.get api(endpoint, id), {
                     "Authorization": "Bearer #{$todoist_token}",
                   }
  end
end
