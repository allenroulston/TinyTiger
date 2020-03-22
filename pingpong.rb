#
require 'discordrb'
require 'yaml'

#####Configuration########
junk = YAML.load(File.read("data.yml"));
puts;
puts "--- here comes the junk value ";
puts junk.inspect;
puts;
puts "here is the token";
token = junk[0]+junk[1]+junk[2];
puts token;
puts;
prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

#####End Configuration####

bot = Discordrb::Bot.new token: token 

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.message(with_text: '[20]') do |event|
  event.respond 'NATURAL 20'
end

bot.message(with_text: '[20]') do |event|
  puts;
  puts event.inspect;
  puts;
end


bot.run








