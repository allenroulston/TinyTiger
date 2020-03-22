#####Configuration########
token = 'I00zRrXmu3LoFYRgIEe4t7qOC9tenXYJ' # Your bot's token
prefix = "!" # Your bot's prefix
owner = '690339632529015005' # Your user ID

#####End Configuration####

require 'discordrb'

bot = Discordrb::Bot.new token: token, client_id: owner

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run











