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

bot.message(contains: "Roll:") do |event|
  tempVar = event.content;  
  theIndex = tempVar.index('Roll:');
  theName = tempVar.slice(0,theIndex).to_s;
  theIndex = tempVar.index('Result:');
  tempResult = tempVar.slice(theIndex,10);
  theResult = tempResult.slice(7,10);
  responseValue = theName + " rolled a " + theResult;
  event.respond responseValue;
end

bot.run