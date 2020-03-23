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

bot.message(contains: "GM-GM") do |event|
  event.respond "Detected Avrae content Damage:";
end

bot.message(contains: "Roll:") do |event|
  comment = " Just saying."
  tempVar = event.content;  
  theIndex = tempVar.index('Roll:');
  theName = tempVar.slice(0,theIndex).to_s;
  theIndex = tempVar.index('Result:');
  tempResult = tempVar.slice(theIndex,10);
  theResult = tempResult.slice(7,10);
  number = theResult.to_i;
  case number
    when 1; comment = "  Critical death save?";
    when 2; comment = "  Just a flesh wound.";
    when 3; comment = "  Maybe no one noticed.";
    when 4; comment = "  Great result on a die 4.";
    when 5; comment = "  Did you remember to add your proficiency?";
    when 6; comment = "  Is that the best you can do?";
    when 7; comment = "  Was it lucky for you, punk?";
    when 8; comment = "  Great roll ... for damage.";
    when 9; comment = "  Hopefully not a death save roll.";
    when 10; comment = "  Solid damage, or did you miss on your attack?";
    when 11; comment = "  Whose side are you on?";
    when 12; comment = "  That will hit a Kobold.";
    when 13; comment = "  Is today a Friday?";
    when 14; comment = "  Twice as good as a seven.";
    when 15; comment = "  That will hit a Troll.";
    when 16; comment = "  That hits a Bugbear.";
    when 17; comment = "  Snap! That probably hit.";
    when 18; comment = "  That will hit most Hobgoblins.";
    when 19; comment = "  So very close.";
    when 20; comment = "  Possible Natural 20.";
    when 21..30; comment = "  That must be a hit."
  end;
  responseValue = theName + "rolled a"  +  theResult + "." + comment;
  event.respond responseValue;
end

bot.run