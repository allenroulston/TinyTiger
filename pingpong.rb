#
require 'discordrb'
require 'yaml'

#####Configuration########
junk = YAML.load(File.read("data.yml"));
token = junk[0]+junk[1]+junk[2];
prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

#####End Configuration####

bot = Discordrb::Bot.new token: token 

#bot.message(with_text: 'ping') do |event|
#  event.respond 'PONG';
#end

#bot.message(contains: "[20]") do |event|
#  event.respond 'SOMEONE ROLLED A NATURAL TWENTY'
#end

bot.message(contains: "[20]") do |event|
  tempVar = "WOW, A NATURAL 20!  "
  tempVar = tempVar + event.author.display_name;
  tempVar = tempVar + " :: " + event.content;
  event.respond tempVar;
end


bot.run