#
require 'discordrb'
require 'yaml'

#####Configuration########
token = (YAML.load(File.read("data.yml"))).to_s;
prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

#####End Configuration####

bot = Discordrb::Bot.new token: token 

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run








