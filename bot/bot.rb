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

bot.command :new_project do |event|
  message = event.message.content.delete_prefix "!new_project "
  project = JSON.parse(
    RestClient.post(
      "#{$internal_url}/projects", {
        name: message,
      }
    )
  )
  if project
    event.respond "On the board!"
  else
    event.respond "Something went wrong"
  end
end

bot.command :delete_project do |event|
  message = event.message.content.delete_prefix "!delete_project "
  RestClient.delete(
    "#{$internal_url}/projects/#{message}"
  )
end

bot.run
