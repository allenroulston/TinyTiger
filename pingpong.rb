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
def check_user_or_nick(event)
  if event.user.nick != nil
    @user = event.user.nick
  else
    @user = event.user.name
  end
end

def parse_the_d();
  theIndex = @tempVar.index('d');
  howManyDice = @tempVar.slice(0,(theIndex));
  return(howManyDice);
end;

bot.message(contains: ".i") do |event|
     check_user_or_nick(event)
     inputStr = event.content; mod = 0; moreChars = true;  extraChar = "none";
     docMsg = "Rolling initiative? Use:  .i  or  .i-1  or  .i2   \n For Advantage / Disadvantage append an  a or d => .i1a "
     lenInputStr = inputStr.length;
     if lenInputStr > 2 then
        extraChar = lenInputStr - 2; # how many characters we will check
        extras = inputStr.slice(2,extraChar-1) # -1 accounts for placement count starts at 0
        (0..(extraChar-1)).each do |x|;
          sample = extras.slice(x,1)   # get one character to sample
          chkResult = ("-1234567890ad").index(sample); # test this sample character     
             if chkResult != nil then;
                moreChars = false;  #if the sample character was not found set moreChars to false
             end;
        end;     
     end;
     
     
     if ( (inputStr.slice(0,2) == '.i';) && ( moreChars == true ) )then;
       
         adv = inputStr.index('a'); dis = inputStr.index('d');
         if (adv != nil) || (dis != nil) then;
             mod = (inputStr.slice(2,lenInputStr-1)).to_i;
         else
             mod = (inputStr.slice(2,lenInputStr)).to_i;
         end;   
         theRoll = (rand 20) + 1;
         say = @user.to_s + " has rolled initiative " + theRoll.to_s + " + " + mod.to_s + " = " + (theRoll+mod).to_s + " =>" + "something";
     else
         say = docMsg; 
     end;
     
     event.respond say;
end;
#bot.message(contains: "d20") do |event|
#  @oneVar = (event.content) + " d20 roll detected";
#end
bot.message(contains: "rth") do |event|
     comment = " Just saying."
     tempVar = event.content;  
     theIndex = tempVar.index('Roll:');
     theName = tempVar.slice(0,theIndex).to_s;
     theIndex = tempVar.index('Result:');
     tempResult = tempVar.slice(theIndex,10);
     theResult = tempResult.slice(7,10);
     number = theResult.to_i;
     if number > 12 then
         responseValue = "The  Combat  Roll  made  by  " + theName + "  of " + theResult + " is a HIT!    Please roll the  damage, " + theName;
      else
         responseValue = "The  Combat  Roll  made  by  " + theName + "  of " + theResult + " is a MISS!";        
      end;
     event.respond responseValue;
end;

bot.message(contains: "qqq") do |event|
    responseValue = "@everyone Please roll initiative as shown:  !roll d20 +?  !qqq  <== !init (important) ";
    event.respond responseValue;
end;


bot.message(contains: "!init") do |event|
  @init = 1;
end;

bot.message(contains: " d20") do |event|
  @d20 = 1;
end;

bot.message(contains: "Roll:") do |event|
  if @init == 1  then;
     comment = " Just saying."
     tempVar = event.content;  
     theIndex = tempVar.index('Roll:');
     theName = tempVar.slice(0,theIndex).to_s;
     theIndex = tempVar.index('Result:');
     tempResult = tempVar.slice(theIndex,10);
     theResult = tempResult.slice(7,10);
     number = theResult.to_i;
     responseValue = "As we determine the initiative order, " + theName + " makes an initiative roll  = = = = = => " + theResult;
     event.respond responseValue;
   end;
   @init = 0;
end;

############################################
bot.message(contains:"d4.") do |event|
    check_user_or_nick(event);
    @tempVar = event.content;
    howManyDice = parse_the_d();
    responseValue = @user.to_s + " provided " + @tempVar.to_s + "  How many d4? :" + howManyDice.to_s;
    event.respond responseValue;
end;

bot.message(contains:"d6.") do |event|
  check_user_or_nick(event);
  @tempVar = event.content;
  howManyDice = parse_the_d();
  responseValue = @user.to_s + " provided " + @tempVar.to_s + "  How many d6? :" + howManyDice.to_s;
  event.respond responseValue;
end;

bot.message(contains:"d8.") do |event|
    check_user_or_nick(event);
    @tempVar = event.content;
    howManyDice = parse_the_d();
    responseValue = @user.to_s + " provided " + @tempVar.to_s + "  How many d8? :" + howManyDice.to_s;
    event.respond responseValue;
end;

bot.message(contains:"d10.") do |event|
    check_user_or_nick(event);
    @tempVar = event.content;
    howManyDice = parse_the_d();
    responseValue = @user.to_s + " provided " + @tempVar.to_s + "  How many d10? :" + howManyDice.to_s;
    event.respond responseValue;
end;

bot.message(contains:"d12.") do |event|
    check_user_or_nick(event);
    @tempVar = event.content;
    howManyDice = parse_the_d();
    responseValue = @user.to_s + " provided " + @tempVar.to_s + "  How many d12? :" + howManyDice.to_s;
    event.respond responseValue;
end;


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
    when 1; comment = "  I hope that wasn't a roll to attack.";
    when 2; comment = "  Just a flesh wound.";
    when 3; comment = "  Maybe no one noticed.";
    when 4; comment = "  Would have been a GREAT result on a die 4.";
    when 5; comment = "  Meh.";
    when 6; comment = "  You have a +10 modifier, right?";
    when 7; comment = "  Was it your lucky number?";
    when 8; comment = "  Great roll ... for damage.";
    when 9; comment = "  Hopefully not a death save roll.";
    when 10; comment = "  A solid roll for damage, too bad it was a roll to hit.";
    when 11; comment = "  Whose side are you on?";
    when 12; comment = "  That will hit a Kobold.";
    when 13; comment = "  Is today a Friday?";
    when 14; comment = "  Twice as good as a seven.";
    when 15; comment = "  That will hit a Troll.";
    when 16; comment = "  That hits a Bugbear.";
    when 17; comment = "  Snap! That probably hit.";
    when 18; comment = "  That will hit most Hobgoblins.";
    when 19; comment = "  Critical Hit, for a Champion.";
    when 20; comment = "  NATURAL 20!";
    when 21..30; comment = "  That must be a hit."
  end;
  responseValue = theName + "rolled a"  +  theResult + "." + comment;
  showText = rand(199)+1;
#  if @d20 == 1 then;
  if showText == 1 then; 
     event.respond responseValue;
     @d20 = 0;
  end;
end

bot.run