class ApplicationRecord < ActiveRecord::Base
  require_relative "../../config/auth.rb"
  require "rest_client"
  require "json"

  primary_abstract_class
end
