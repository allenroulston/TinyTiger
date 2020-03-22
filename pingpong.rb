# Prerequisites: discordrb, Ruby (>2.3 install devkit)
# Use: Replace "insert token" with your token 
#	   Replace "your id" with Your user ID
#      Change the prefix



require "discordrb"
require "yaml"

#####Configuration########
token = (YAML.load(File.read("data.yml"))).to_s;
prefix = "!" # Your bot's prefix
owner = "690339632529015005" # Your user ID

#####End Configuration####

bot = Discordrb::Commands::CommandBot.new(token: token, prefix: prefix)

bot.command(:ping, description: "Responds with `Pong` along with the response time", usage: "#{prefix}ping") do |event|
	msg = event.respond("Pong?")
	msg.edit("Pong! Response time: #{Time.now - event.timestamp} seconds.")
end


bot.command(:o, description: "Owner Commands", usage: "#{prefix}o [sub] [*args]") do |event, sub, *args|
	break unless event.user.id.to_s == owner
	case sub
    when "eval"
        begin
            event.channel.send_embed do |embed|
                embed.add_field(name: "Input: ", value: "```\n#{args.join(' ')}```")
                embed.add_field(name: "Output: ", value: "```\n#{eval args.join(' ')}```")
                embed.colour = 0x01960d
            end
        rescue
            'An error occurred'
        end
    when "exec"
        begin
            eval "`#{args.join(' ')}`"
        rescue
            'An error occurred'
        end
    when "shutdown"
        begin 
            event.channel.send_embed do |embed|
                embed.title = "Shutting down"
                embed.description = "The Bot Is Shutting Down"
                embed.colour = 0xef0000
            end
            sleep 1
            bot.stop
        rescue
            'An error occurred'
        end
	end
end