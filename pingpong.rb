#!/usr/bin/ruby
require 'discordrb'

bot = Discordrb::Bot.new token: 'I00zRrXmu3LoFYRgIEe4t7qOC9tenXYJ', client_id: 690339632529015005

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run











