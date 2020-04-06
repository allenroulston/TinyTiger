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

@zeroAC=10; @oneAC=10; @twoAC=10; @threeAC=10; @fourAC=10; @fiveAC=10; @sixAC=10; @sevenAC=10; @eightAC=10; @nineAC=10;
@AllenABSmod=[3,4,5,3,4,5];
@SqueeABSmod=[0,3,2,-1,1,2];


def find_the_creature(v1);
  case v1
       when 0; @itis="@zeroAC"; 
       when 1; @itis="@oneAC"; 
       when 2; @itis="@twoAC"; 
       when 3; @itis="@threeAC"; 
       when 4; @itis="@fourAC"; 
       when 5; @itis="@fiveAC"; 
       when 6; @itis="@sixAC"; 
       when 7; @itis="@sevenAC"; 
       when 8; @itis="@eightC";          
       when 9; @itis="@nineAC";
  end;
  return(@itis);
end;

def check_char_name(code);
   case code;
       when "a";  @charName = "Allen";
       when "c";  @charName = "Cordax Glimscale";
       when "d";  @charName = "Daisho/ Samurai War Priest";
       when "o";  @charName = "Ollodash";
       when "q";  @charName = "Quincey";
       when "s";  @charName = "Squee / Rogue";
       when "z";  @charName = "Zalos / Bladesinger";
    end;
end;

def check_user_or_nick(event)
  if event.user.nick != nil
    @user = event.user.nick
  else
    @user = event.user.name
  end
end


bot.message(contains: ".i") do |event|
     check_user_or_nick(event)
     inputStr = event.content; mod = 0; moreChars = true;
     docMsg = "Rolling initiative? Use:  .i  or  .i-1  or  .i2   \nFor Advantage/Disadvantage append an  a or d => .ia or .i2a"
     lenInputStr = inputStr.length;
     
     if lenInputStr > 2 then
        extraCharLen = lenInputStr - 2; # how many characters we will check
        extras = inputStr.slice(2,extraCharLen) # extract extra characters
        (0..(extraCharLen-1)).each do |x|;
          sample = extras.slice(x,1)   # get one character to sample
          chkResult = ("-1234567890ad").index(sample); # test this sample character     
             if chkResult == nil then;
                moreChars = false;  #if the sample character was not found set moreChars to false
             end;
        end;     
     end;
     
     adv = inputStr.index('a'); dis = inputStr.index('d');  # was a d or a found in the input string?
     if (adv != nil) && (dis != nil) then; moreChars = false; end; # if both a & d found, bail out.
     
     if moreChars == true then;   #bail if bad chars already detected
        if (adv != nil) || (dis != nil) then;  # if an a or a d were found :
           endChar = extras.slice((extraCharLen-1),1); # grab the last character
           if (endChar != "a") && (endChar != "d") then # if last character is NOT a AND not d, bail
              moreChars = false;
           end;
        end;
     end;  
     
     if ( (inputStr.slice(0,2) == '.i';) && ( moreChars == true ) )then;  
       # a or d found (or not) in above code
         if (adv != nil) || (dis != nil) then;  # if an a or a d were found :
             mod = (inputStr.slice(2,lenInputStr-1)).to_i;  # drop the last letter
             rollOne = (rand 20)+1; rollTwo = (rand 20)+1; #make two rolls
             theRolls = "[" + rollOne.to_s + "," + rollTwo.to_s + "]";
             if adv != nil then;
                theRoll = [rollOne,rollTwo].max;
             else;
               theRoll = [rollOne,rollTwo].min;
             end;
         else;
             mod = (inputStr.slice(2,lenInputStr)).to_i;  #keep all of the characters
             theRoll = (rand 20) + 1;
             theRolls = "[" + theRoll.to_s + "]";
         end;   
         say = @user.to_s + " has rolled an initiative of: " + theRolls.to_s + " + " + mod.to_s + " = " + (theRoll+mod).to_s;
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

bot.message(matches: ";i") do |event|
    inputValue = event.content;
    if inputValue == ";i"; then;
       responseValue = "@everyone Please roll initiative:   ;ic   ;id   ;io   ;iq   ;is   ;iz  \nare programmed for each character with Dex mod.";
       event.respond responseValue;
    end;
end;

########## Unique INITIATIVE ########
bot.message(contains: ";i") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(2,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";ia"; mod=9;
            when ";ic"; mod=1;
            when ";id"; mod=2;
            when ";io"; mod=0;
            when ";iq"; mod=3;
            when ";is"; mod=3;
            when ";iz"; mod=3;
       end;
       iRoll=(rand 20)+1;
       result = iRoll + mod;
       responseValue = @user.to_s + " has rolled initiative: [" + iRoll.to_s + "] + " + mod.to_s + " = " + result.to_s;
       event.respond responseValue;
    end;
end;

######### ATTACK TARGETED #####################################
bot.message(contains: ";a") do |event|
    inputValue = event.content;
    targetInt = false;
    
    if (inputValue.length > 3) then
       target = inputValue.slice(3,1);
       targetInt = Integer(target) rescue false
    end;
    
    check_user_or_nick(event)
    code = inputValue.slice(2,1);
    inputName = check_char_name(code); # input name pulled from method up top; Discord user name
    if (targetInt != false) && (@user == inputName) then;
            tcode = inputValue.slice(0,3);
            case tcode;
               when ";aa"; mod=9;
               when ";ac"; mod=5;
               when ";ad"; mod=5;
               when ";ao"; mod=5;
               when ";aq"; mod=5;
               when ";as"; mod=5;
               when ";az"; mod=5;
            end;
            iRoll=(rand 20)+1;
            result = iRoll + mod;
            say = @user.to_s + " rolled an attack: [" + iRoll.to_s + "] + " + mod.to_s + " = " + result.to_s + "\n";
            if (result < @armour[target.to_i]) then;
               say = say + "The attack Missed!";
            else;
               say = say + "The attack HIT!";
            end;
    else;
       say = "Attack needs  ;aX?   X= first initial   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

########## DAMAGE ##############
bot.message(contains: ";d") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(2,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";da"; dType=12; dMod=9;
            when ";dc"; dType=6; dMod=1;
            when ";dd"; dType=10; dMod=3;
            when ";do"; dType=8; dMod=3;
            when ";dq"; dType=6; dMod=3; 
            when ";ds"; dType=6; dMod=3;
            when ";dz"; dType=8; dMod=3;
       end;
       dmgRoll=(rand dType)+1;
       result = dmgRoll + dMod;
       responseValue = @user.to_s + " [d" + dType.to_s + "] damage roll: [" + dmgRoll.to_s + "] + " + dMod.to_s + " = " + result.to_s;
       event.respond responseValue;
    end;
end;

########## DAMAGE 1 ##############
bot.message(contains: ";d1") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(3,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";d1a"; dType=12; dMod=9;
            when ";d1c"; dType=4; dMod=1;
            when ";d1d"; dType=4; dMod=3;
            when ";d1o"; dType=4; dMod=3;
            when ";d1q"; dType=4; dMod=3; 
            when ";d1s"; dType=4; dMod=3;
            when ";d1z"; dType=4; dMod=3;
       end;
       dmgRoll=(rand dType)+1;
       result = dmgRoll + dMod;
       responseValue = @user.to_s + " [d" + dType.to_s + "] damage roll: [" + dmgRoll.to_s + "] + " + dMod.to_s + " = " + result.to_s;
       event.respond responseValue;
    end;
end;

########## DAMAGE Sneak Attack Dagger d4 ##############
bot.message(contains: ";SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       dagger = (rand 4)+1;
       totalDmg = totalDmg + dagger +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " Sneak Attack (dagger) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "]   [" + dagger.to_s + "] + 3 = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;


########## DAMAGE Sneak Attack Dagger d4 CRITICAL ##############
bot.message(contains: ";SAD!4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       dagger1 = (rand 4)+1; dagger2 = (rand 4)+1;
       totalDmg = totalDmg + dagger1 + dagger2 +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " CRITICAL Sneak Attack (dagger) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "]   [" + dagger1.to_s+ "][" + dagger2.to_s + "] + 3 = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 ##############
bot.message(contains: ";SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       ssword = (rand 6)+1;
       totalDmg = totalDmg + ssword +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " Sneak Attack (short sword) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "]   [" + ssword.to_s + "] + 3 = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 CRITICAL ##############
bot.message(contains: ";SAD!6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       short1 = (rand 6)+1; short2 = (rand 6)+1;
       totalDmg = totalDmg + short1 + short2 +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " CRITICAL Sneak Attack (short sword) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "]   [" + short1.to_s+ "][" + short2.to_s + "] + 3 = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;


########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(contains: ";SAD8") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       rapier = (rand 8)+1;
       totalDmg = totalDmg + rapier +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " Sneak Attack (rapier) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "]   [" + rapier.to_s + "] + 3 = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(contains: ";SAD!8") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       rapier1 = (rand 8)+1; rapier2 = (rand 8)+1;
       totalDmg = totalDmg + rapier1 + rapier2 +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " CRITICAL Sneak Attack (rapier) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "]   [" + rapier1.to_s+ "][" + rapier2.to_s + "] + 3 = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot cause this damage type.";
    end;
  event.respond responseValue;
end;

########## DAMAGE Grave Bolt ##############
bot.message(contains: ";GB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];
         end;
       totalDmg = totalDmg +3; #hard coded for Squee and Quincey
       responseValue = @user.to_s + " Grave Bolt damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "]  + 3 = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Booming Blade ##############
bot.message(contains: ";BB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        totalDmg= (rand 8) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + " Booming Blade damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Frost Bite ##############
bot.message(contains: ";FB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        totalDmg= (rand 6) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + "  Frost Bite damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s + "\nTarget makes a CON save. Failure means Disadvantage on next attack.";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Shocking Grasp ##############
bot.message(contains: ";SG") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        totalDmg= (rand 8) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + "  Shocking Grasp damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Toll of the Dead ##############
bot.message(contains: ";TD") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
        lDmg = (rand 8) +1; bDmg = (rand 12) +1;  # Hard coded for Zalos
       responseValue = @user.to_s + "  Toll of the Dead damage: full HP:[" + lDmg.to_s + "]  or   Injured HP:[" + bDmg.to_s + "]\n" + 
                                    "Target makes a WIS save to take no damage.";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
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

def parse_the_d();
  theIndex = @tempVar.index('d');
  howManyDice = @tempVar.slice(0,(theIndex));
  return(howManyDice);
end;

#########################################
###########  Armour Class  ##############
#########################################
bot.message(contains:"$load") do |event|
    check_user_or_nick(event);
    if @user == "Allen" then;
       @armour = Array.new
       @armour = [12,12,12,12,12,12,12,12,12,12,12];
                
       event.respond "Just to let you know, $load just ran.";
    end;
end;

bot.message(contains:"$c") do |event|
    check_user_or_nick(event);
    if @user == "Allen" then;
         inputStr = event.content; # creature Number and AC should be in the string
         whatIsNumAC = Integer(inputStr.slice(2,1)) rescue false
         if (inputStr.length == 3) && (whatIsNumAC != false) then;
             cNum = inputStr.slice(2,1);
             acVal = @armour[cNum.to_i].to_s;    
          event.respond "The current AC for creature "  +cNum + " is the value " + acVal;
       end;
    end;
end;

bot.message(contains:"$set") do |event|
    check_user_or_nick(event);
    if @user == "Allen" then;
         inputStr = event.content; # creature Number and AC should be in the string
         whatIsNumAC = Integer(inputStr.slice(4,3)) rescue false
         if (inputStr.length == 7) && (whatIsNumAC != false) then;            
             cNum = (inputStr.slice(4,1));
             if cNum == "0" then cNum = 0; else; cNum = cNum.to_i end;
             acVal = inputStr.slice(5,2);
             @armour[cNum]=acVal.to_i;
                 
          event.respond "Armour Class for Creature " + cNum.to_s + " was set to AC: " + acVal.to_s;
       end;
    end;
end;

bot.message(contains:"$ALL") do |event|
    check_user_or_nick(event);
    if @user == "Allen" then;
         inputStr = event.content; # creature Number and AC should be in the string
         whatIsNumAC = Integer(inputStr.slice(4,2)) rescue false
         if (inputStr.length == 6) && (whatIsNumAC != false) then;
             acVal = inputStr.slice(4,2);
             (0..9).each do |x|;
                  @armour[x]=acVal.to_i;
              end;                 
          event.respond "ALL creatures now have an AC of: " + acVal.to_s;
       end;
    end;
end;
##########################################
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