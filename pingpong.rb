#
require 'discordrb'
require 'yaml'


#####Configuration########
junk = YAML.load(File.read("data.yml"));
token = junk[0]+junk[1]+junk[2];

prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

@armour = YAML.load(File.read("armourClass.yml"));
@weapon = YAML.load(File.read("weaponDamage.yml"));
@player = YAML.load(File.read("ABSmods.yml"));

def check_user_or_nick(event)
  if event.user.nick != nil
    @user = event.user.nick
  else
    @user = event.user.name
  end
end
 

#####End Configuration####

bot = Discordrb::Bot.new token: token 

@AllenABSmod=[3,4,5,3,4,5];
@SqueeABSmod=[0,3,2,-1,1,2];

def valTheInny(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheInny = true;
  length = inputStr.length;
  @charInit = inputStr.slice(2,1);
  chkLtr = ("acdoqsz").index(@charInit); # test this sample character 
  numbVal = inputStr.slice(3,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 4) || (chkLtr == nil) || (chkNum == false) then;
    @valTheInny = false;
  end;
end; 

def validate_integer(numbVal);
    @intVal = Integer(numbVal) rescue false;
end;

def valTheRTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheRTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(4,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 5) || (chkNum == false) then;
    @valTheRTH = false;
  end;
end; 

def valTheInnyBlessed(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
    @valTheInnyBlessed = true;
    length = inputStr.length;
    @charInit = inputStr.slice(3,1);
    chkLtr = ("acdoqsz").index(@charInit); # test this sample character 
    numbVal = inputStr.slice(4,1);
    chkNum = Integer(numbVal) rescue false;
    if (length != 5) || (chkLtr == nil) || (chkNum == false) then;
      @valTheInnyBlessed = false;
    end;
end;  
  

def str_2_number(value);
  if value == "0" then;
     @numba = 0;
  else
    @numba = Integer(value);
  end;  
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

bot.message(matches: ";i") do |event|
    inputValue = event.content;
    if inputValue == ";i"; then;
       responseValue = "@everyone Please roll initiative with command:   ;init \n"+
                      "(The bot knows your character ability score modifiers.)";
       event.respond responseValue;
    end;
end;

########## Unique INITIATIVE ########
bot.message(contains: ";init") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    get_the_player();
    mod = @player[@playerIndex][3];
    initRoll=(rand 20)+1;
    result = initRoll + mod;
    responseValue = @user.to_s + " has rolled initiative: [" + initRoll.to_s + "] + " + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

######### easy ATTACK TARGET creature #####################################
bot.message(contains: ";rth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheRTH(inputValue); #standard validation process found up top
    if (@valTheRTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];
      mod = [mod1,mod2].max;
      str_2_number(inputValue.slice(4,1)); target = @numba # @numba <= is the result
      iRoll=(rand 20)+1; result = iRoll + mod;
      say = @user.to_s + " rolled an attack: [" + iRoll.to_s + "] + " + mod.to_s + " = " + result.to_s + "\n";
          if (result < @armour[target]) then;
              say = say + "The attack Missed!";
          else;
              say = say + "The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              roll_damage(@player[@playerIndex][1]); #damage die type in @player
              #@damage & @damage1 now have values
              if @damage1 == -99 then;
                say = say + "\n" + @player[@playerIndex][1].to_s + " rolled [" + @damage.to_s + "] + " + mod.to_s + " = " + (mod + @damage).to_s;
              else;
                say = say + "\n" + @player[@playerIndex][1].to_s + " rolled [" + @damage.to_s + "] + [" + @damage1.to_s + "] + " + mod.to_s + " = " + (mod + @damage + @damage1).to_s;
              end;
          end;
          
    else;
       say = "Attack needs  ;aX?   X= first initial   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;



######### ATTACK TARGETED #####################################
bot.message(contains: ";a") do |event|
    inputValue = event.content;
    targetInt = false;
    valTheInny(inputValue); #standard validation process found up top
    if (@valTheInny == true) then;    
             check_user_or_nick(event);   nameInitial = inputValue.slice(2,1);
             inputName = check_char_name(nameInitial); # input name pulled from method up top; Discord user name 
        if (@user == inputName) then;
                 tcode = inputValue.slice(0,3);       
                 case tcode;
                      when ";aa"; mod=7;
                      when ";ac"; mod=5;
                      when ";ad"; mod=5;
                      when ";ao"; mod=5;
                      when ";aq"; mod=5;
                      when ";as"; mod=5;
                      when ";az"; mod=5;
                 end;
                 str_2_number(inputValue.slice(3,1)); target = @numba # @numba <= is the result
                 iRoll=(rand 20)+1; result = iRoll + mod;
                 say = @user.to_s + " rolled an attack: [" + iRoll.to_s + "] + " + mod.to_s + " = " + result.to_s + "\n";
                 if (result < @armour[target]) then;
                    say = say + "The attack Missed!";
                 else;
                    say = say + "The attack HIT!";
                 end;
        else;
          say = "Attack needs  ;aX?   X= first initial   ?= target number (0 to 9)";
        end;
    else;
       say = "Attack needs  ;aX?   X= first initial   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### ATTACK TARGETED while BLESSED #####################################
bot.message(contains: ";ba") do |event|
    inputValue = event.content;
    targetInt = false;
    valTheInnyBlessed(inputValue); #standard validation process found up top
    if (@valTheInnyBlessed == true) then;    
             check_user_or_nick(event);   nameInitial = inputValue.slice(3,1); # position 3 is the character initial
             inputName = check_char_name(nameInitial); # input name pulled from method up top; Discord user name 
        if (@user == inputName) then;
                 tcode = inputValue.slice(0,4);  # we need chars postions 0,1,2,3 to validate the character     
                 case tcode;
                      when ";baa"; mod=7;
                      when ";bac"; mod=5;
                      when ";bad"; mod=5;
                      when ";bao"; mod=5;
                      when ";baq"; mod=5;
                      when ";bas"; mod=5;
                      when ";baz"; mod=5;
                 end;
                 str_2_number(inputValue.slice(4,1)); target = @numba # @numba <= is the result
                 iRoll1=(rand 20)+1;   bless = (rand 4) + 1;
                 result = iRoll1 + bless;
                 say = @user.to_s + " rolled a BLESSED attack: [" + iRoll1.to_s + "] + [" + bless.to_s + "] = " + result.to_s + "\n";
                 if (result < @armour[target]) then;
                    say = say + "The attack Missed!";
                 else;
                    say = say + "The attack HIT!";
                 end;
        else;
          say = "Blessed Attack needs  ;baX?   X= first initial   ?= target number (0 to 9)";
        end;
    else;
       say = "Blessed Attack needs  ;baX?   X= first initial   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

########## DAMAGE ##############
bot.message(contains: ";d1") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(3,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";d1a"; dType=12; dMod=9;
            when ";d1c"; dType=6; dMod=1;
            when ";d1d"; dType=10; dMod=3;
            when ";d1o"; dType=8; dMod=3;
            when ";d1q"; dType=6; dMod=3; 
            when ";d1s"; dType=6; dMod=3;
            when ";d1z"; dType=8; dMod=3;
       end;
       dmgRoll=(rand dType)+1;
       result = dmgRoll + dMod;
       responseValue = @user.to_s + " Weapon 1 damage [d" + dType.to_s + "] damage roll: [" + dmgRoll.to_s + "] + " + dMod.to_s + " = " + result.to_s;
       event.respond responseValue;
    end;
end;

########## DAMAGE CRITICAL;d!1 ##############
bot.message(contains: ";d!1") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(4,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";d!1a"; dType=12; dMod=9;
            when ";d!1c"; dType=6; dMod=1;
            when ";d!1d"; dType=10; dMod=3;
            when ";d!1o"; dType=8; dMod=3;
            when ";d!1q"; dType=6; dMod=3; 
            when ";d!1s"; dType=6; dMod=3;
            when ";d!1z"; dType=8; dMod=3;
       end;
       dmgRoll1=(rand dType)+1;
       dmgRoll2=(rand dType)+1;       
       result = dmgRoll1 +dmgRoll2 + dMod;
       responseValue = @user.to_s + " Weapon 1 Critical damage [d" + dType.to_s + "] damage roll: [" + dmgRoll1.to_s + "] + [" + dmgRoll2.to_s + "] + "  + dMod.to_s + " = " + result.to_s;
       event.respond responseValue;
    end;
end;

########## DAMAGE 1 ##############
bot.message(contains: ";d2") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(3,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";d2a"; dType=10; dMod=6;
            when ";d2c"; dType=4; dMod=1;
            when ";d2d"; dType=4; dMod=3;
            when ";d2o"; dType=4; dMod=3;
            when ";d2q"; dType=4; dMod=3; 
            when ";d2s"; dType=4; dMod=3;
            when ";d2z"; dType=4; dMod=3;
       end;
       dmgRoll=(rand dType)+1;
       result = dmgRoll + dMod;
       responseValue = @user.to_s + " Weapon 2 damage [d" + dType.to_s + "] damage roll: [" + dmgRoll.to_s + "] + " + dMod.to_s + " = " + result.to_s;
       event.respond responseValue;
    end;
end;

########## DAMAGE CRITICAL;d!2 ##############
bot.message(contains: ";d!2") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    code = inputValue.slice(4,1);
    inputName = check_char_name(code);
    if @user == inputName then; 
       case inputValue;
            when ";d!2a"; dType=10; dMod=6;
            when ";d!2c"; dType=4; dMod=1;
            when ";d!2d"; dType=4; dMod=3;
            when ";d!2o"; dType=4; dMod=3;
            when ";d!2q"; dType=4; dMod=3; 
            when ";d!2s"; dType=4; dMod=3;
            when ";d!2z"; dType=4; dMod=3;
       end;
       dmgRoll1=(rand dType)+1;
       dmgRoll2=(rand dType)+1;       
       result = dmgRoll1 +dmgRoll2 + dMod;
       responseValue = @user.to_s + " Weapon 2 Critical damage [d" + dType.to_s + "] damage roll: [" + dmgRoll1.to_s + "] + [" + dmgRoll2.to_s + "] + "  + dMod.to_s + " = " + result.to_s;
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
       responseValue = @user.to_s + "  Frost Bite damage: [" + totalDmg.to_s + "] = " + totalDmg.to_s +
                  "\nIf target makes a CON save, no damage or effect. Failure means damage & Disadvantage on next attack.";
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

########## DAMAGE Chromatic Orb ##############
bot.message(contains: ";CO") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 8)+1;
              totalDmg=totalDmg + dDie[x];
         end;
         lesserDmg = totalDmg - dDie[3];
         responseValue = @user.to_s + " Chromatic Orb damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + lesserDmg.to_s +
                                       "\nUp Cast damage would add [" + dDie[3].to_s + "] = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Dragon Breath ##############
bot.message(contains: ";DB") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];
         end;
         responseValue = @user.to_s + " Dragon Breath damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s +
                                       "\nHalf damage to target with a successful DEX save";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;


########## DAMAGE Magic Missle ##############
bot.message(contains: ";MM") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 4)+1;
              totalDmg=totalDmg + dDie[x] + 4;
         end;
         lesserDmg = totalDmg - dDie[3] -1;
         responseValue = @user.to_s + " Magic Missile damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] +3 = " + lesserDmg.to_s +
                                       "\nUp Cast damage would add [" + dDie[3].to_s + "] +1 = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Aganazzar's Scorcher ##############
bot.message(contains: ";AS") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 8)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " Aganazzar's Scorcher damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s +
                                       "\nTarget makes a DEX save to take half damage";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Scorching Ray ##############
bot.message(contains: ";SR") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3,4,5]; totalDmg=0;
         (0..5).each do |x|;
              dDie[x]=(rand 6)+1;
         end;
         ray1 = dDie[0] + dDie[1];
         ray2 = dDie[2] + dDie[3];
         ray3 = dDie[4] + dDie[5];
         
         responseValue = @user.to_s + " Scorching Ray damage, for each of the three (3) rays: " + 
                                      "\n[" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + ray1.to_s +
                                      "\n[" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + ray2.to_s +
                                      "\n[" + dDie[4].to_s + "][" + dDie[5].to_s + "] = " + ray3.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE ACID vial ##############
bot.message(contains: ";ACID") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1]; totalDmg=0;
         (0..1).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " has used Acid to cause disfiguration and damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s;
    event.respond responseValue;
end;

########## DAMAGE !ACID vial ##############
bot.message(contains: ";!ACID") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 6)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " has used Acid with a Critical Hit: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + totalDmg.to_s;
    event.respond responseValue;
end;

########## DAMAGE AFIRE ##############
bot.message(contains: ";AFIRE") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0]; totalDmg=0;
         dDie[0]=(rand 4)+1;
         totalDmg=totalDmg + dDie[0];
         responseValue = @user.to_s + " has used Alchemical Fire to cause disfiguration and damage: [" + dDie[0].to_s +  "] = " + totalDmg.to_s; + 
                                      "\nTarget keeps burning (burn baby, burn) until they use their action to extinguish the flames (DC10 Dex)";
    event.respond responseValue;
end;

########## DAMAGE !AFIRE ##############
bot.message(contains: ";!AFIRE") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1]; totalDmg=0;
         dDie[0]=(rand 4)+1; dDie[1]=(rand 4)+1;
         totalDmg=totalDmg + dDie[0] + dDie[1];
         responseValue = @user.to_s + " has used Alchemical Fire with a Critical Hit: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s; + 
                                      "\nTarget keeps burning (burn baby, burn) until they use their action to extinguish the flames (DC10 Dex)";
    event.respond responseValue;
end;

########## DAMAGE Healing Word ##############
bot.message(contains: ";HWORD") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,5) == "Daish") || (@user.slice(0,5) == "Allen") then
         dDie = [0]; totalDmg=0;
         dDie[0]=(rand 4)+1;
         totalDmg=totalDmg + dDie[0] + 2;
         responseValue = @user.to_s + " has used Healing Word to heal someone for: [" + dDie[0].to_s +  "] + 2 = " + totalDmg.to_s; + " HP";
    else;
            responseValue = "Sorry, you cannot cast the spell. " ;
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

bot.message(contains:"$c") do |event|
    check_user_or_nick(event); say = "";
    if @user == "Allen" then; # as long as the user is Allen, perform the following
            (0..9).each do |x|;
                acVal = @armour[x].to_s;
                say = say + "Creature " + x.to_s + " has Armour Class " + acVal + "\n";
            end;           
    end;
    event.respond say;
end;

bot.message(contains:"$Wlist") do |event|
    check_user_or_nick(event);
    get_the_player(); # this assigns a value to @playerIndex
    say = @user + ", your current weapon damage die is set to: " + @weapon[(@player[@playerIndex][1])].to_s + "\n\n";
    say = say +  "To change weapons, assign a new damage die value using: $Wset \n" +
                 "with an Integer, as shown below. Such as $Wset3 \n\n";
    (0..5).each do |x|;
          say = say +  @weapon[x] + " <=> " + x.to_s  + "    ";
    end;                 
    event.respond say;
end;

bot.message(contains:"$Wset") do |event|
    inputStr = event.content; # this should contain "$Wset#" where # is a single digit
    get_the_player(); # this assigns a value to @playerIndex
    weaponInt = inputStr.slice(5,1)
    validate_integer(weaponInt) # sets @intVal as an integer or false
    if @intVal != false then;   # if the string can be made into an INTEGER
          str_2_number(weaponInt); # this will turn a string integer into an INTEGER => @numba
          if @numba <= @weapon.length then;   # value cannot be higher than number of weapons
             @player[@playerIndex][1] = @numba;  #assign the character weapon damage die value
             say = "Your weapon damage has be set to " + @weapon[(@player[@playerIndex][1])].to_s;
          else;
              say = "Sorry, $Wset requires this format: $Wset?  where ? is a single number ( 0 to 5 )";         
          end;
    else
       say = "Sorry, $Wset requires this format: $Wset?  where ? is a single number ( 0 to 5 )"; 
    end;
    event.respond say;
end;


bot.message(contains:"$ACset") do |event|
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
             (0..9).each do |x|;
                  @armour[x]=acVal.to_i; 
             end;     
          event.respond "ALL creatures now have an AC of: " + acVal.to_s;
    end;
end;

def get_the_player();
    player5Char = @user.slice(0,5); #taking first 5 characters of @user
    y=0; #used to track the current index value for the array
    @player.each do |x|;
           if x[0] == player5Char then; # find the player Index matching player5Char
              @playerIndex = y;
           end;
      y=y+1
    end;
end;

def roll_damage(damType);
  case damType;
     when "2d6"; @damage = (rand 6)+1; @damage1 = (rand 6)+1;    
     when "1d12"; @damage = (rand 12)+1; @damage1 = -99;
     when "1d10"; @damage = (rand 10)+1; @damage1 = -99;
     when "1d8"; @damage = (rand 8)+1; @damage1 = -99;
     when "1d6"; @damage = (rand 6)+1; @damage1 = -99;
     when "1d4"; @damage = (rand 4)+1; @damage1 = -99;
  end;
end;


bot.run