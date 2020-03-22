#####Configuration########
token = 'NjkwMzM5NjMyNTI5MDE1MDA1.XnZ0uw.j4wXcl0SXHLG0Sx2EzWLK5lFUII' # Your bot's token
prefix = "!" # Your bot's prefix
owner = '690339632529015005' # Your user ID

#####End Configuration####

require 'discordrb'

bot = Discordrb::Bot.new token: token, client_id: owner

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run











