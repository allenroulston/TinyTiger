#!/usr/bin/ruby
require 'discordrb'

bot = Discordrb::Bot.new token: 'NjkwMzM5NjMyNTI5MDE1MDA1.XnZ0uw.j4wXcl0SXHLG0Sx2EzWLK5lFUII', client_id: 690339632529015005

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run











