require "discordrb"
require_relative "../config/auth.rb"

bot = Discordrb::Commands::CommandBot.new token: $discord_token, prefix: "!"

bot.command :user do |event|
  event.user.name
end

bot.command :projects do |event|
  projects = JSON.parse RestClient.get "#{$internal_url}/projects"
  project_names = projects.map do |prjct| prjct["name"] end.join(", ")
  event.respond project_names
end

bot.run
