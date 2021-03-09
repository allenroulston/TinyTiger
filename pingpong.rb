#
require 'discordrb';
require 'yaml';
require 'date';
require 'securerandom';
include Math;


##########  Configuration  ########
junk = YAML.load(File.read("data.yml"));
token = junk[0]+junk[1]+junk[2];

prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

puts;
@armour = YAML.load(File.read("armourClass.yml"));
puts "          The Tiny Tiger is prepared for battle"
puts;
@HP = YAML.load(File.read("hitPoints.yml"));
@weapon = YAML.load(File.read("weaponDamage.yml"));
@player = YAML.load(File.read("ABSmods.yml"));
@RE = YAML.load(File.read("relentEndure.yml"));

@dmg1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
@dmg2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
@dmg3 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
@dmg4 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

@gmBonus = 5;
###### End of Configuration ####


def check_user_or_nick(event)
  if event.user.nick != nil
    @user = event.user.nick
  else
    @user = event.user.name
  end
end
#####################################

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

def valTheARTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheARTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(5,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 6) || (chkNum == false) then;
    @valTheARTH = false;
  end;
end;

####### RAGE check ######
def valTheRARTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheRARTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(6,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 7) || (chkNum == false) then;
    @valTheRARTH = false;
  end;
end;


def valTheBRTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheBRTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(5,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 6) || (chkNum == false) then;
    @valTheBRTH = false;
  end;
end; 

def valTheABRTH(inputStr);  # use to validate the input of type ;az1. (attack by Zalos where target # 1)
  @valTheABRTH = true;
  length = inputStr.length;
  numbVal = inputStr.slice(6,1);
  chkNum = Integer(numbVal) rescue false;
  if (length != 7) || (chkNum == false) then;
    @valTheABRTH = false;
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

bot = Discordrb::Bot.new token: token

################## 2help ############################################ 2help ##########################
################## 2help ############################################ 2help ##########################
bot.message(start_with:"help") do |event|
  say = "help: COMMAND [space] COMMENT\n";
  say = say + "   d4.   d6.   d8.   d10.   d12.   d20.  or d100.  \n";
  say = say + "d20.  rolls 1d20 + 0           d20.6   rolls 1d20 + 6 \n";
  say = say + "d20a.4   rolls Advantage     =>  1d20 + 4   \n";
  say = say + "d20d.-5  rolls Dis-Advantage =>  1d20 - 5   \n";
  say = say + "d4.3  rolls 1d4 + 3       d6.-2    rolls 1d6 -2 \n";
  say = say + "2d8.  rolls 2d8 + 0       3d8.-1   rolls 3d8 -1 \n";
  say = say + "\nTry pchelp to modify ability modifiers\n";
  event.respond say;
end;
################## 2help ############################################ 2help ##########################
################## 2help ############################################ 2help ##########################
bot.message(start_with:"pchelp") do |event|
  say = "pchelp [command] HELP for PC commands  \n"; 
  say = say + "$EDITst# Strength     \n";
  say = say + "$EDITdx# Dexterity    \n";  
  say = say + "$EDITco# Constitution \n";
  say = say + "$EDITin# Intelligence \n";
  say = say + "$EDITwi# Wisdom       \n"; 
  say = say + "$EDITch# Charisma     \n";     
  say = say + "$EDITpb# Proficiency Bonus \n";  
  say = say + "$EDITme# Melee Weapon Damage \n";
  say = say + "$EDITra# Range Weapon Damage \n";   
  say = say + "$EDITcs# Casting ABS Stat \n";  
  say = say + "$EDITsh# Sharp Shooter?";    
  event.respond say;
end;
################## gmhelp ############################################ 2help ##########################
################## gmhelp ############################################ 2help ##########################
bot.message(start_with:"gmhelp") do |event|
  say = "gmhelp [command] HELP for the GM commands  \n";  
  say = say + "$sethp@#  $setallhp##  $abclist \n";
  say = say + "$setac@#  $setallac##  $abclist";
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$abclist") do |event|;  
   monsterHP = YAML.load(File.read("testHPAC.yml"));   alphabet = "ABCDEFGHIJKLMNOPQRST";   say = "Hit Points & AC\n";
   (0..(monsterHP.length-1)).each do |x|;
       target = alphabet.slice(x,1);
       say = say + "**" + target + "**   " + monsterHP[x][0].to_s + "  of  " + monsterHP[x][1].to_s + "     AC " + monsterHP[x][2].to_s + "\n";
   end;              
      event.respond say;
 end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$sethp") do |event|;  
   monsterHP = YAML.load(File.read("testHPAC.yml"));
   alphabet = "ABCDEFGHIJKLMNOPQRST";   critter = event.content.slice(6,1);   position = alphabet.index(critter); 
   hitPoints = event.content.slice(7,3).to_i;
   if (position != nil) && (hitPoints != 0) then;  
       monsterHP[position][0] = hitPoints;
       monsterHP[position][1] = hitPoints * 1.0;
       data = "---\n"
#  Go through the list of critters and append the data to the preceeding data
       (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
              File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
      say = "Set HP process complete.";
   else
      say = "Nothing happened.";
   end;
      event.respond say;
 end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$setallhp") do |event|;  
    monsterHP = YAML.load(File.read("testHPAC.yml"));   hitPoints = event.content.slice(9,3).to_i;
    if (hitPoints != nil) && (hitPoints != 0) then;
       (0..(monsterHP.length-1)).each do |z|
          monsterHP[z][0] = hitPoints;
          monsterHP[z][1] = hitPoints * 1.0;
       end;
        data = "---\n"
 #  Go through the list of critters and append the data to the preceeding data
        (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
               File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Setting ALL HP process complete.";
    else
       say = "Nothing happened.";
    end;
       event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$setac") do |event|;  
    monsterAC = YAML.load(File.read("testHPAC.yml"));
    alphabet = "ABCDEFGHIJKLMNOPQRST";   critter = event.content.slice(6,1);   position = alphabet.index(critter); 
    theAC = event.content.slice(7,3).to_i;
    if (position != nil) && (theAC != 0) then;  
        monsterAC[position][2] = theAC;
        data = "---\n"
 #  Go through the list of critters and append the data to the preceeding data
        (0..(monsterAC.length-1)).each do |x|;    data = data + "- " + monsterAC[x].to_s + "\n";   end;               
               File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Set AC process complete.";
    else
       say = "Nothing happened.";
    end;
       event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
bot.message(start_with: "$setallac") do |event|;  
    monsterHP = YAML.load(File.read("testHPAC.yml"));   armour = event.content.slice(9,2).to_i;
    if (armour != nil) && (armour != 0) then;
       (0..(monsterHP.length-1)).each do |z|
          monsterHP[z][2] = armour;
       end;
        data = "---\n"
 #  Go through the list of critters and append the data to the preceeding data
        (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
               File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Setting ALL HP process complete.";
    else
       say = "Nothing happened.";
    end;
       event.respond say;
end;
###############################################################################################
###############################################################################################
#             Proof of concept. Reading and writing data to a text file. 
###############################################################################################
###############################################################################################
bot.message(start_with: "$EDIT") do |event|;  
   player = YAML.load(File.read("testABSmods.yml"));
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;   flag= false;
   pIndex = nil;
   (0..(player.length-1)).each do |y|
       if (player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
   end;
   case  event.content.slice(0,7);
      when "$EDITst"; flag = true; stat=1;
      when "$EDITdx"; flag = true; stat=2;
      when "$EDITco"; flag = true; stat=3;
      when "$EDITin"; flag = true; stat=4;
      when "$EDITwi"; flag = true; stat=5;
      when "$EDITch"; flag = true; stat=6;
      when "$EDITpb"; flag = true; stat=7;
      when "$EDITme"; flag = true; stat=8;
      when "$EDITra"; flag = true; stat=9;
      when "$EDITcs"; flag = true; stat=10;
      when "$EDITsh"; flag = true; stat=11;
   end;
   if flag == true then;
     say = "st:" + player[pIndex][1].to_s + "  dx:" + player[pIndex][2].to_s + "  co:" + player[pIndex][3].to_s +
          "  in:" + player[pIndex][4].to_s + "  wi:" + player[pIndex][5].to_s + "  ch:" + player[pIndex][6].to_s + "\n";
     say = say + "ProfB:" + player[pIndex][7].to_s +  "   CastStat:" + player[pIndex][10].to_s  + "\n";
     say = say + "MeleeW:" + player[pIndex][8].to_s + "   RangeW:" + player[pIndex][9].to_s + "\n";
     say = say + "SharpShooter:" + player[pIndex][11].to_s + "\n";
          
     player[pIndex][stat]=event.content.slice(7,3).to_i; #assignment of new stat modifier

     say = say + "\n The player stat mod for [" + event.content.slice(5,2) + "] is now: " + player[pIndex][stat].to_s + "\n";
     say = say + "\n st:" + player[pIndex][1].to_s + "  dx:" + player[pIndex][2].to_s + "  co:" + player[pIndex][3].to_s +
               "  in:" + player[pIndex][4].to_s + "  wi:" + player[pIndex][5].to_s + "  ch:" + player[pIndex][6].to_s + "\n";
     say = say + "ProfB:" + player[pIndex][7].to_s +  "   CastStat:" + player[pIndex][10].to_s  + "\n";
     say = say + "MeleeW:" + player[pIndex][8].to_s + "   RangeW:" + player[pIndex][9].to_s + "\n";
     say = say + "SharpShooter:" + player[pIndex][11].to_s;
               
data = "---\n";
#     we go through the list of characters and append the data to the preceeding data
       (0..(player.length-1)).each do |x|; 
           a1 = "- " + player[x].to_s + "\n";
           data = data + a1;
       end;               
       File.open("testABSmods.yml", 'w+') {|f| f.write(data) };
   end;
   event.respond say;
end;
###############################################################################################
###############################################################################################
#             Read the ABS details for a character
###############################################################################################
###############################################################################################
bot.message(start_with: "$READ") do |event|;  
   player = YAML.load(File.read("testABSmods.yml"));
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event..slice(5,5); end;   flag= false;
   pIndex = nil;
   (0..(player.length-1)).each do |y|
       if (player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
       puts "==> " + player.inspect
   end;

   if pIndex != nil then;
     say = "ST:" + player[pIndex][1].to_s + "   DX:" + player[pIndex][2].to_s + "   CO:" + player[pIndex][3].to_s +
           "   IN:" + player[pIndex][4].to_s + "   WI:" + player[pIndex][5].to_s + "   CH:" + player[pIndex][6].to_s + "\n";
     say = say + "Prof B:" + player[pIndex][7].to_s +  "   Cast Stat:" + player[pIndex][10].to_s  + "\n";
     say = say + "Melee W:" + player[pIndex][8].to_s + "   Range W:" + player[pIndex][9].to_s + "\n";
     say = say + "SharpShooter:" + player[pIndex][11].to_s + "\n";
   else;
     say = "That didn't work.";
   end;
   event.respond say;
end;          
###############################################################################################
###############################################################################################
#             Proof of concept. Reading and writing data to CREATURE Hit Points file. 
###############################################################################################
###############################################################################################
bot.message(start_with: "$damage") do |event|;  
   monsterHP = YAML.load(File.read("testHPAC.yml"));
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;   flag= false;
   pIndex = nil; say = "We read the monsterHP"; alphabet = "ABCDEFGHIJKLMNOPQRST";
   critter = event.content.slice(7,1);   position = alphabet.index(critter);   damage = event.content.slice(8,5).to_i;
   if (position != nil) && (damage != 0) then;  
       monsterHP[position][0] = monsterHP[position][0] - damage;
       data = "---\n"
#  Go through the list of critters and append the data to the preceeding data
       (0..(monsterHP.length-1)).each do |x|;    data = data + "- " + monsterHP[x].to_s + "\n";   end;               
              File.open("testHPAC.yml", 'w+') {|f| f.write(data) };
       say = "Deducted " + damage.to_s + " hp from Creature " + critter;
       perCent = monsterHP[position][0]/monsterHP[position][1];
       if perCent < 0.00010 then; health = "Down"; end;  # less than 0.0001 is only possible when HP = 0 or less 
       if perCent > 0.00000 then; health = "Battered"; end;
       if perCent > 0.24999 then; health = "Bloodied"; end;
       if perCent > 0.49999 then; health = "Bruised"; end;
       if perCent > 0.74999 then; health = "Healthy"; end;
       say = say + "\nCreature " + critter + " is " + health;       
   else
     say = "Something is wrong with this: " + event.content;
   end;
   event.respond say;
end;
###############################################################################################
###############################################################################################
#             Proof of concept. ONE Roll To Hit method with multiple SWITCHES
###############################################################################################
###############################################################################################
bot.message(start_with: "RTH") do |event|;      event.message.delete;
   theChars = YAML.load(File.read("testABSmods.yml"));  roll = rand(1..20);  r2 = rand(1..20);  r3 = rand(1..20);  r4 = rand(1..20);
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;   alphabet = "ABCDEFGHIJKLMNOPQRST";
   switches = event.content.slice(4,99);   pIndex = nil;   target = event.content.slice(3,1);   position = alphabet.index(target);
            (0..(theChars.length-1)).each do |y|
                if (theChars[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value
            end;         #puts "Target: " + target.inspect + "      Position: " + position.inspect; 
   if (position == nil) || (target == "") then;
      say = "Target missing: " + event.content;
   else;
       #---------------------------------------------------------------------------------------------------------------------#
       adv = switches.index("a");   dis = switches.index("d");   range = switches.index("m"); # nil value means NOT found   
       bless = switches.index("b");
       rage = switches.index("r");  huntM = switches.index("h");  smite = switches.index("s");
       #---------------------------------------------------------------------------------------------------------------------#
       say = event.content + " **" + theChars[pIndex][0] + "** vs " + target + ":";
       statMod = [theChars[pIndex][2],theChars[pIndex][3]].max; # max of ST or DX mod
       if (range != nil) then statMod = theChars[pIndex][3]; end; # ranged attack uses DEX abs mod
       if (adv == nil) && (dis == nil) then;
          total = roll + theChars[pIndex][8] + statMod;
          say = say + " [" + roll.to_s + "]+" + theChars[pIndex][8].to_s + "p+" + statMod.to_s + "a";
       else;
          if (adv != nil) then
            roll = [r2,r3].max; total = roll + theChars[pIndex][8] + statMod;
            say = say + " [" + r2.to_s + "][" + r3.to_s + "]+" + theChars[pIndex][8].to_s + "p+" + statMod.to_s + "a";
          else;
            roll = [r3,r4].min; total = roll + theChars[pIndex][8] + statMod;
            say = say + " [" + r3.to_s + "][" + r4.to_s + "]+" + theChars[pIndex][8].to_s + "p+" + statMod.to_s + "a";           
          end;
       end;
       if (bless != nil) then; b = rand(1..4); total = total + b; say = say + "+" + b.to_s + "b"; end;
       say = say + "= " + total.to_s;
       weaponData = YAML.load(File.read("weaponDamage.yml"));  # melee 1 & 12 range 
       if range == nil then; weaponDmg = theChars[pIndex][1]; else; weaponDmg = theChars[pIndex][12]; end;
       mHPAC = YAML.load(File.read("testHPAC.yml"));   mAC = mHPAC[position][2];
     if (roll > 1) then;
       if total >= mAC then;  
         if (roll != 20) then;
         case weaponDmg;
            when 0; d1=rand(1..6);d2=rand(1..6);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d6
            when 1; d1=rand(1..12);dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d12
            when 2; d1=rand(1..10);dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d10
            when 3; d1=rand(1..8);dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d8
            when 4; d1=rand(1..6);dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d6
            when 5; d1=rand(1..4);dmgT=d1+statMod; dDice ="[" + d1.to_s + "]+" + statMod.to_s + "a";# 1d4
            when 6; d1=rand(1..3);d2=rand(1..3);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d3
            when 7; d1=rand(1..4);d2=rand(1..4);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d4
            when 8; d1=rand(1..5);d2=rand(1..5);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d5
         end;
         say = say + "    HIT!";
         else;
         case weaponDmg;
            when 0; d1=rand(1..6);d2=rand(1..6);d3=rand(1..6);d4=rand(1..6);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 2d6
            when 1; d1=rand(1..12);d2=rand(1..12);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d12
            when 2; d1=rand(1..10);d2=rand(1..10);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d10
            when 3; d1=rand(1..8);d2=rand(1..8);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d8
            when 4; d1=rand(1..6);d2=rand(1..6);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d6
            when 5; d1=rand(1..4);d2=rand(1..4);dmgT=d1+d2+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "]+" + statMod.to_s + "a";# 1d4
            when 6; d1=rand(1..3);d2=rand(1..3);d3=rand(1..3);d4=rand(1..3);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "][" + d3.to_s + "][" + d4.to_s + "]+" + statMod.to_s + "a";# 2d3
            when 7; d1=rand(1..4);d2=rand(1..4);d3=rand(1..4);d4=rand(1..4);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "][" + d3.to_s + "][" + d4.to_s + "]+" + statMod.to_s + "a";# 2d4
            when 8; d1=rand(1..5);d2=rand(1..5);d3=rand(1..5);d4=rand(1..5);dmgT=d1+d2+d3+d4+statMod; dDice ="[" + d1.to_s + "][" + d2.to_s + "][" + d3.to_s + "][" + d4.to_s + "]+" + statMod.to_s + "a";# 2d5
         end;
         say = say + "    CRITICAL HIT!";
       end;
       say = say + "\n\u2937 " + dDice ; huntMDmg = 0;
       if huntM != nil then; 
         huntMDmg = rand(1..6); say = say + "+[" + huntMDmg.to_s + "h]";
       end;

        mHPAC[position][0] = mHPAC[position][0] - dmgT - huntMDmg;
        data = "---\n"    #  Go through the list of critters and append the data to the preceeding data
        (0..(mHPAC.length-1)).each do |x|;    data = data + "- " + mHPAC[x].to_s + "\n";   end;               
        File.open("testHPAC.yml", 'w+') {|f| f.write(data) };     
        say = say + "= " + dmgT.to_s + " hp deducted, Creature " + target;     
        perCent = mHPAC[position][0]/mHPAC[position][1];
        if perCent < 0.00010 then; health = "Down"; end;  # less than 0.0001 is only possible when HP = 0 or less 
        if perCent > 0.00000 then; health = "Battered"; end;
        if perCent > 0.24999 then; health = "Bloodied"; end;
        if perCent > 0.49999 then; health = "Bruised"; end;
        if perCent > 0.74999 then; health = "Healthy"; end;
        say = say + " is " + health;
      else;
       say = say + "    **Missed**";
      end;
     else;
       say = say + "    **Natural One**";
     end;
     event.respond say;
   end;
end;

##################################################################################################################
####################################################################################################################################  d4. ##########################
##################################################################################################################
bot.message(contains:"d4.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d4.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+3),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d4.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d4" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..4);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d6. ##########################
bot.message(contains:"d6.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d6.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+3),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d6.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d6" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..6);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d8. ##########################
bot.message(contains:"d8.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d8.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+3),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d8.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d8" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..8);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d10. ##########################
bot.message(contains:"d10.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d10.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d10.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d10" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..10);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d12. ##########################
bot.message(contains:"d12.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d12.");
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  spacePos = afterDieStr.index(" "); comment = "#d12.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d12" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..12);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d20. ##########################
bot.message(contains:"d20.") do |event|
  event.message.delete;  check_user_or_nick(event);  total = 0;  theString = event.content; diePosition = theString.index("d20.");
  
  begin; numbA = Integer(theString.slice(0,diePosition)); rescue; numbA = 1; end;  afterDieStr = theString.slice((diePosition+4),99).strip;
  
  spacePos = afterDieStr.index(" "); comment = "#d20.# [space] comment";   ### puts spacePos.inspect; puts "*" + afterDieStr + "*";
  
  if spacePos != nil then;     #### when a SPACE exists within afterDieStr do this stuff
     begin; numbB = Integer(afterDieStr.slice(0,spacePos)); rescue; numbB = 0; end;
     if numbB == 0; comment = afterDieStr.slice(0,99); else; comment = afterDieStr.slice(spacePos,99); end;
  else;    ### puts " spacePos IS nil:     " + spacePos.inspect;
     begin; numbB = Integer(afterDieStr.slice(0,99)); rescue; numbB = 0; end;
     if afterDieStr.length != 0 && numbB == 0 then; comment = afterDieStr.slice(0,99); end;
  end;
  theDice = Array.new;   ### puts "numbA " + numbA.to_s + "      numbB " + numbB.to_s;
  say = @user.to_s + " rolled " + numbA.to_s + "d20" + "+" + numbB.to_s + "  (" + theString.slice(0,9) + ")" + "\n";
  (0..(numbA-1)).each do |x|;  theDice[x] = rand(1..20);  say = say + "[" + theDice[x].to_s + "]";  total = total + theDice[x];  end; #rolls the required dice
  total = total + numbB;      say = say + " + " + numbB.to_s + " = " + total.to_s;      say = say + "\nREASON: " + comment;
  event.respond say;
end;

################## d20a. ##########################
bot.message(start_with:"d20a.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;   
    parse_the_d("d20a.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d20a. requires  d20a. OR  ?d20a.? where ? are integers (1 to 9)."
    else
       say = @user.to_s + " rolled 2d20" + " + " + @whatPlus.to_s + " with Advantage \n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..1).each do |x|;
           die[x]=(rand 20)+1;
           say = say + "[" + die[x].to_s + "]";
       end;
       bigDie = [die[0],die[1]].max;
       total = bigDie + @whatPlus;
       say = say + "       [" + bigDie.to_s + "] + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "  REASON: " + comment;
       say = say + "\n~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~";
    end;
    event.respond say;
end;

################## d20d. ##########################
bot.message(start_with:"d20d.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    parse_the_d("d20d.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d20d. requires  d20d. OR  ?d20d.? where ? are integers (1 to 9)."
    else
       say = @user.to_s + " rolled 2d20" + " + " + @whatPlus.to_s + " with Dis-Advantage \n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..1).each do |x|;
           die[x]=(rand 20)+1;
           say = say + "[" + die[x].to_s + "]";
       end;
       bigDie = [die[0],die[1]].min;
       total = bigDie + @whatPlus;
       say = say + "       [" + bigDie.to_s + "] + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "  REASON: " + comment;
       say = say + "\n---------------";
    end;
    event.respond say;
end;
##################################################################################################################
################################################################################################################## TREASURE CALCULATIONS
########################0123456789################################################################################
bot.message(start_with:"CASH") do |event|;
  def cr0to4(theRoll);
    case theRoll;
      when 1..30; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=cash.to_s + " copper";
      when 31..60; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=cash.to_s + " silver";
      when 61..70; cash=rand(1..6)+rand(1..6)+rand(1..6)+1; cash=(cash/2).to_s + " gold";
      when 71..95; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=cash.to_s + " gold";
      when 96..100; cash=rand(1..6); cash=cash.to_s + " platinum";
    end;
    return cash; 
  end;
  def cr5to10(theRoll);
    case theRoll;
      when 1..30; cash1=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6); cash=(cash1*100).to_s + " copper & " + (cash2*5).to_s + " gold";
      when 31..60; cash1=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6)+rand(1..6); cash=(cash1*10).to_s + " silver" + " & " + (cash2*10).to_s + " gold";
      when 61..70; cash1=rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6)+rand(1..6);cash=((cash1*5)+(cash2*10)).to_s + " gold";
      when 71..95; cash=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6); cash=(cash*10).to_s + " gold";
      when 96..100; cash1=rand(1..6)+rand(1..6); cash2=rand(1..6)+rand(1..6)+rand(1..6);cash=(cash1*10).to_s + " gold & " + (cash2*10).to_s + " platinum";
    end;
    return cash; 
  end;  
  def cr11to16(theRoll);
    case theRoll;
      when 1..20; cash1=rand(1..6)+rand(1..6)+rand(1..6)+rand(1..6);cash2=rand(1..6);cash1=(cash1*100).to_s + " silver & " + (cash2*100).to_s + " gold";
      when 21..35; cash1=rand(1..6);cash2=rand(1..6); cash=(cash1*50)+(cash2*100).to_s + " gold";
      when 36..75; cash1=rand(1..6)+rand(1..6);cash2=rand(1..6);cash=(cash1*100).to_s + " gold & " + (cash2*10).to_s + " platinum";
      when 76..100; cash1=rand(1..6)+rand(1..6); cash2=rand(1..6)+rand(1..6);cash=(cash1*100).to_s + " gold & " + (cash2*10).to_s + " platinum";
    end;
    return cash; 
  end; 
      
  event.message.delete
  crTreasure = event.content.slice(4,5).to_i;
  theRoll = rand(1..100);
  if crTreasure > 16 then; cash = "Too large a CR number."; end;
  if crTreasure < 17 then; cash = cr11to16(theRoll); end;
  if crTreasure < 11 then; cash = cr5to10(theRoll); end;   
  if crTreasure < 5 then; cash = cr0to4(theRoll); end;
 
  say = "CR value is " + crTreasure.to_s + "\n" + cash;
  
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################

##################################################################################################################
##################################################################################################################
bot.message(start_with: "myabs") do |event|;
  if event.user.nick != nil
      theUser = event.user.nick
  else
      theUser = event.user.name
  end;
    pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    stMod = @player[pIndex][2];
    dxMod = @player[pIndex][3];
    coMod = @player[pIndex][4];
    inMod = @player[pIndex][5];
    wiMod = @player[pIndex][6];
    chMod = @player[pIndex][7];
    prMod = @player[pIndex][8];
    meleeDamage = @player[pIndex][1];
    rangeDamage = @player[pIndex][12];
    say = theUser + " has Proficiency Bonus of " + prMod.to_s + "  and ability score modifiers of \n";
    say = say + "ST: " + stMod.to_s + "  DX: " + dxMod.to_s + "  CO: " + coMod.to_s + "  IN: " + inMod.to_s + "  WI: " + wiMod.to_s + "  CH: " + chMod.to_s + "\n";
    say = say + "Default MELEE weapon damage: " + @weapon[meleeDamage] ;
    say = say + "\nDefault RANGED weapon damage: " + @weapon[rangeDamage] ;
    say = say + "\n=======> use $Wlist to change default weapon damage.";
    event.respond say;
end;

bot.message(start_with:"55555") do |event|;
  def tis_this(input);
    bork = input;
    say = bork.to_s + " this.";
    return say; 
  end;  
  event.message.delete
  theSay = tis_this(event.content)
  event.respond theSay;
end;


bot.message(contains:"fly") do |event|;
  event.message.delete;  theString = event.content; flyStartsHere = theString.index("fly")
  numbA = theString.slice(0,flyStartsHere); numbB = theString.slice((flyStartsHere+3),99);
  numbA = numbA.to_i; numbB = numbB.to_i;
  numbC = Math.sqrt((numbA * numbA) + (numbB * numbB))
  theSay = numbA.to_s + " fly " + numbB.to_s + " = " + numbC.round(1).to_s;
  event.respond theSay;
end;


bot.message(start_with: ";deleteme") do |event|;
      say = "The Message ID was: " + event.message.id.to_s;
      say = say + "\nThe Author ID was: " + event.author.id.to_s;
      say = say + "\nThe Autthor name was: " + event.author.username.to_s
#      say = say + "\n" + event.author.discriminator.to_s. #      say = say + "\n" + event.author.server.name.to_s
#      say = say + "\n" + event.author.server.id.to_s.     #      say = say + "\n" + event.channel.inspect.to_s
#      say = say + "\n" + event.content.to_s;              #      say = say + "\n" + event.file.to_s;
#      say = say + "\n" + event.message.to_s;              #      say = say + "\n" + event.saved_message.to_s;
#      say = say + "\n" + event.server.to_s;               #      say = say + "\n" + event.timestamp.to_s;
#      say = say + "\n\n" + event.author.inspect.to_s;
       say = say + "\nWhom said: " + event.content.to_s;
       say = say  + "\n\nI just deleted it!";
       event.message.delete;
      event.respond say;
end;

bot.message(start_with: ".i") do |event|
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
    event.message.delete;     
     event.respond say;
end;

bot.message(start_with: ";i") do |event|
    inputValue = event.content;
    event.message.delete;
    if inputValue == ";i"; then;
       responseValue = "@everyone Please pause whatever you are doing.\n" +
                       "Roll initiative using the command: ii \n (two lower case 'eyes') \n" +
                       "(The bot knows your character ability score modifiers.)";
       event.respond responseValue;
    end;
end;

########## Unique INITIATIVE ########
bot.message(start_with: "ii") do |event|
    event.message.delete; 
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    mod = @player[pIndex][3] + @player[pIndex][9];     initRoll=(rand 20)+1;      result = initRoll + mod;
    responseValue = theUser.to_s + " has rolled initiative: [" + initRoll.to_s + "] + " + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

########## Advantage Unique INITIATIVE ########
bot.message(start_with: "aii") do |event|
    event.message.delete; 
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    initRoll1=(rand 20)+1;     initRoll2=(rand 20)+1;     initRoll = [initRoll1,initRoll2].max;
    result = initRoll + mod + @player[pIndex][9];
    responseValue = theUser.to_s + " has rolled initiative with ADVANTAGE: [" + initRoll1.to_s + "][" + initRoll2.to_s + "] + "  + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

########## DisAdvantage Unique INITIATIVE ########
bot.message(start_with: "dii") do |event|
    event.message.delete; 
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    initRoll1=(rand 20)+1;     initRoll2=(rand 20)+1;     initRoll = [initRoll1,initRoll2].min;
    result = initRoll + mod + @player[pIndex][9];
    responseValue = theUser.to_s + " has rolled initiative with DIS-ADVANTAGE: [" + initRoll1.to_s + "][" + initRoll2.to_s + "] + "  + mod.to_s + " = " + result.to_s;
    event.respond responseValue;
end;

#################################################################################
################## manual CREATURE/MONSTER damage ###############################
bot.message(start_with:"dmg") do |event|
    event.message.delete;   check_user_or_nick(event);    letterDamage = event.content.slice(3,99); # creature LETTER and DAMAGE should be in the string
    sym = "\u2193"+"\u2193"+"\u2193";   blank = letterDamage.index(' ');     comment = "There was no comment provided."
    if blank != nil then; # in the case where there is a BLANK, there is a comment to extract
      comment = letterDamage.slice(blank,99);  #extracting the comment (anything after the blank)
    end; 
       alphaVal = letterDamage.slice(0,1);  # FIRST character should be a CAPITAL LETTER
       begin; target = "ABCDEFGHIJKLMNOPQRSTU".index(alphaVal); rescue; target = false; end; # translate the LETTER to a number
       begin; hpDamage = ((letterDamage.slice(1,3)).chomp).to_i; rescue; hpDamage = 0; end;  # up to 3 characters of DAMAGE converted to an integer

       if (target != false) && (hpDamage != 0) && (@user.slice(0,5) == "Allen") then;  # ensure VALID damage value & VALID creature Number
            @HP[target][0] = @HP[target][0] - hpDamage;  # deduct the HP from the creature
            if (@RE[target]==1) && (@HP[target][0] < 1) then;    @RE[target] = 0; @HP[target][0] = 1;   end;
            say = sym + "  " + comment + "  " + sym + "\n";  
            say = say + "Creature " + alphaVal + "  (" + target.to_s + ") reduced by " + hpDamage.to_s + " hit points.";
            health_check(@HP[target][0], @HP[target][1]);
            say = say + "\nCreature " + alphaVal + "  (" + target.to_s + ")  is " + @healthStat;
       else;
            say = "(" + event.content + ") dmgAB where A is Target Letter and B is the HP (integer)"
       end;
    event.respond say;
end;

######## HEALTH CHECK ########## ######## HEALTH CHECK ##########
def health_check(currentHp, originalHp);
  perCent = currentHp/originalHp;
  if perCent < 0.00010 then; @healthStat = "Down"; end;  # less than 0.0001 is only possible when HP = 0 or less 
  if perCent > 0.00000 then; @healthStat = "Battered"; end;
  if perCent > 0.24999 then; @healthStat = "Bloodied"; end;
  if perCent > 0.49999 then; @healthStat = "Bruised"; end;
  if perCent > 0.74999 then; @healthStat = "Healthy"; end;
end;

####### GET_DAMAGES #########
def get_damages(pIndex)
  theWeaponIndex = @weapon[(@player[pIndex][1])];
  case theWeaponIndex;
       when "2d6";  @dmg1 = (rand 6)+1;  @dmg2 = (rand 6)+1; @dmg3 = (rand 6)+1;  @dmg4 = (rand 6)+1;
       when "1d12"; @dmg1 = (rand 12)+1; @dmg2 = -99;        @dmg3 = (rand 12)+1; @dmg4 = -99;
       when "1d10"; @dmg1 = (rand 10)+1; @dmg2 = -99;        @dmg3 = (rand 10)+1; @dmg4 = -99;
       when "1d8";  @dmg1 = (rand 8)+1;  @dmg2 = -99;        @dmg3 = (rand 8)+1;  @dmg4 = -99;
       when "1d6";  @dmg1 = (rand 6)+1;  @dmg2 = -99;        @dmg3 = (rand 6)+1;  @dmg4 = -99;
       when "1d4";  @dmg1 = (rand 4)+1;  @dmg2 = -99;        @dmg3 = (rand 4)+1;  @dmg4 = -99;
       when "2d4";  @dmg1 = (rand 4)+1;  @dmg2 = (rand 4)+1; @dmg3 = (rand 4)+1;  @dmg4 = (rand 4)+1;
       when "2d3";  @dmg1 = (rand 3)+1;  @dmg2 = (rand 3)+1; @dmg3 = (rand 3)+1;  @dmg4 = (rand 3)+1;
  end;
end;

####### GET_DAMAGES #########
def get_Rdamages(pIndex)
  theWeaponIndex = @weapon[(@player[pIndex][12])];
  case theWeaponIndex;
       when "2d6";  @dmg1 = (rand 6)+1;  @dmg2 = (rand 6)+1; @dmg3 = (rand 6)+1;  @dmg4 = (rand 6)+1;
       when "1d12"; @dmg1 = (rand 12)+1; @dmg2 = -99;        @dmg3 = (rand 12)+1; @dmg4 = -99;
       when "1d10"; @dmg1 = (rand 10)+1; @dmg2 = -99;        @dmg3 = (rand 10)+1; @dmg4 = -99;
       when "1d8";  @dmg1 = (rand 8)+1;  @dmg2 = -99;        @dmg3 = (rand 8)+1;  @dmg4 = -99;
       when "1d6";  @dmg1 = (rand 6)+1;  @dmg2 = -99;        @dmg3 = (rand 6)+1;  @dmg4 = -99;
       when "1d4";  @dmg1 = (rand 4)+1;  @dmg2 = -99;        @dmg3 = (rand 4)+1;  @dmg4 = -99;
       when "2d4";  @dmg1 = (rand 4)+1;  @dmg2 = (rand 4)+1; @dmg3 = (rand 4)+1;  @dmg4 = (rand 4)+1;
       when "2d3";  @dmg1 = (rand 3)+1;  @dmg2 = (rand 3)+1; @dmg3 = (rand 3)+1;  @dmg4 = (rand 3)+1;
  end;
end;

def prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
  @sayValue = "";
  iTarget = "ABCDEFGHIJKLMNOPQRSTU".slice(target,1);
  get_damages(pIndex); # go to method to get the damages
  if rage == 0; then ra = ""; end;  
  if rage == 2; then ra = "+(2)"; end;
  if rage == 3; then ra = "+(3)"; end;
  if rage == 4; then ra = "+(4)"; end;
  if rage == 5; then ra = "+(5)"; end;
  #puts "----> " + @dmg1[pIndex].to_s + " - " + @dmg2[pIndex].to_s + " - " + @dmg3[pIndex].to_s + " - " + @dmg4[pIndex].to_s;
  if iRoll != 20 then;
       if (@weapon[(@player[pIndex][1])] != "2d6") && (@weapon[(@player[pIndex][1])] != "2d4") && (@weapon[(@player[pIndex][1])] != "2d3") then;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + rage).to_s + " points of damage.";
         #puts "HP: " + @HP[target][0].to_s + "   @dmg1: " +  @dmg1.to_s + "  mod: " +  mod.to_s + "  target: " + target.to_s + " @healthStat: " +  @healthStat.inspect; 
         @HP[target][0] = @HP[target][0] - @dmg1 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       else;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + @dmg2 + rage).to_s + " points of damage.";
         @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       end;
  else;   # NATURAL 20
       if (@weapon[(@player[pIndex][1])] != "2d6") && (@weapon[(@player[pIndex][1])] != "2d4") && (@weapon[(@player[pIndex][1])] != "2d3") then;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg3.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + @dmg3 + rage).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg3 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       else;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][1])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "][" + @dmg3.to_s + "][" + @dmg4.to_s + "] + " + mod.to_s + ra + " = " + (mod + @dmg1 + @dmg2 + @dmg3 + @dmg4 + rage).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - @dmg3 - @dmg4 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") is " + @healthStat + "\n";
       end;              
  end;
end;

######### easy ATTACK TARGET creature #####################################
bot.message(start_with: "mrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = theUser + " made a MELEE roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "MELEE Roll To Hit needs  mrth?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;


######### HexBlade Agonizing Blast ATTACK TARGET creature #####################################
######### HexBlade Agonizing Blast ATTACK TARGET creature #####################################
bot.message(start_with: "agblast") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(7,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 8) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][7];   mod2 = @player[pIndex][7];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = theUser + " Ag Blast roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "Ag Blast Roll To Hit needs  agblast?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;



######### WOLF ATTACK TARGET creature #####################################
bot.message(start_with: "wolf") do |event|
    if event.user.nick != nil; theUser = "Wolfs"; else; theUser = "Wolfs"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "Wolf made a BITE roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "wolf needs  wolf?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### WOLF ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "awolf") do |event|
    if event.user.nick != nil; theUser = "Wolfs"; else; theUser = "Wolfs"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;  

    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "Wolf made a BITE Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end;      
    else;
      say = "wolf needs  wolf?   ?= target letter A to K";
    end;    
    event.respond say;
end;

######### BEAR BITE ATTACK TARGET creature #####################################
bot.message(start_with: "bite") do |event|
    if event.user.nick != nil; theUser = "Bear2"; else; theUser = "Bear2"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "BEAR made a BITE roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "bite needs  bite?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### BEAR ADVANTAGE BITE ATTACK TARGET creature #####################################
bot.message(start_with: "abite") do |event|
    if event.user.nick != nil; theUser = "Bear2"; else; theUser = "Bear2"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "BEAR made a BITE Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "abite needs  abite?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### BEAR CLAW ATTACK TARGET creature #####################################
bot.message(start_with: "claw") do |event|
    if event.user.nick != nil; theUser = "Bear1"; else; theUser = "Bear1"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "BEAR made a CLAW roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "claw needs  claw?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### BEAR ADVANTAGE CLAW ATTACK TARGET creature #####################################
bot.message(start_with: "aclaw") do |event|
    if event.user.nick != nil; theUser = "Bear1"; else; theUser = "Bear1"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "BEAR made a CLAW Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "aclaw needs  aclaw?   ?= target letter A to K";
    end;
    event.respond say;
end;

#####
#####
#####
######### HEX BLADE ELDRITCH BLAST ATTACK TARGET creature #####################################
bot.message(start_with: "eblast") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "Eldritch Blast roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "eblast needs eblast?  ?= target letter A to K";
    end;
    event.respond say;
end;

###################################################################################################

###################################################################################################

######### HEX BLADE ELDRITCH BLAST HEX ATTACK TARGET creature #####################################
bot.message(start_with: "hceb") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO EBLAS
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = "Hexblade Curse Eldritch Blast roll to hit Creature " + iTarget + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
      if iRoll == 19 then iRoll = 20; end;    
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";               rage = profB; # using rage to carry the Hex Blade added damage (prof bonus)
              prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "hceb needs hceb?  ?= target letter A to K";
    end;
    event.respond say;
end;

######### HEX BLADE ELDRITCH BLAST ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "aeblast") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(7,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 8) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = "Eldritch Blast Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "aeblast needs aeblast?   ?= target letter A to K";
    end;
    event.respond say;
end;

######### HEX BLADE ELDRITCH BLAST DIS-ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "deblast") do |event|
    if event.user.nick != nil; theUser = "EBLAS"; else; theUser = "EBLAS"; end; pIndex = nil;  # SET THE USER VALUE TO Wolfs
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(7,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 8) || (target == nil) then;  validInput = false;  end;     
    
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB;
       say = "Eldritch Blast Dis roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "dblasta needs dblast?   ?= target letter A to K";
    end;
    event.respond say;
end;

####
####
####

######### easy ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "marth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;  

    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = theUser + " made a MELEE Adv roll to hit Creature " + iTarget + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end;      
    else;
    say = "MELEE Advanatage Roll To Hit needs  marth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy RAGE ATTACK TARGET creature #####################################
bot.message(start_with: "mRrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;     
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = theUser + " made a MELEE roll to hit Creature " + target.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n";
          else;
              say = say + "     ... HIT!";
              rage=2; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
              say = say + @sayValue;
          end;
    else;
    say = "MELEE RAGE Roll To Hit needs  mrth?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;

#########  RAGE ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "mRarth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;  
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB;
       say = theUser + " made a MELEE RAGE Adv roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=2; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
       say = "RAGE MELEE Advanatage Roll To Hit needs  Rmarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy DISADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "mdrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;  
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB;
       say = theUser + " made a MELEE DisA roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
    say = "MELEE Dis-Advanatage Roll To Hit needs  mdrth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "mbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end;      
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;  bless=(rand 4)+1;  iRoll=(rand 20)+1; result = iRoll + mod + profB + bless;
      say = theUser + " made a MELEE Blessed roll to hit Creature " + target.to_s + ":\n[" + iRoll.to_s + "]+[" + bless.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
    say = "MELEE Blessed Roll To Hit needs  mbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "mabrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;      
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   bless=(rand 4)+1;  roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB + bless;
      say = theUser + " made a MELEE Adv Bless roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][ " + roll2.to_s + "] + [" + bless.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
       say = "MELEE Advantage Blessed Roll To Hit needs  mabrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy Melee DIS-ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "mdbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end;  
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   bless=(rand 4)+1;  roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB + bless;
      say = theUser + " made a MELEE DisA Bless roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][ " + roll2.to_s + "] + [" + bless.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            rage=0; prepare_damage_report(iRoll, pIndex, mod, profB, target, rage);
            say = say + @sayValue;
          end; 
    else;
       say = "Melee Dis-Advantage Blessed Roll To Hit needs  mdbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;
############
############
############
############ RANGE ATTACK DAMAGE REPORT
def prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
  @sayValue = "";
  iTarget = "ABCDEFGHIJKLMNOPQRSTU".slice(target,1);
  get_damages(pIndex); # go to method to get the damages
  if sharp == 10; then shsh = "+(10)"; else; shsh = ""; end;
  #puts "----> " + @dmg1[pIndex].to_s + " - " + @dmg2[pIndex].to_s + " - " + @dmg3[pIndex].to_s + " - " + @dmg4[pIndex].to_s;
  if iRoll != 20 then;
       if (@weapon[(@player[pIndex][12])] != "2d6") && (@weapon[(@player[pIndex][12])] != "2d4") && (@weapon[(@player[pIndex][12])] != "2d3") then;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + sharp).to_s + " points of damage.";
         #puts "HP: " + @HP[target][0].to_s + "   @dmg1: " +  @dmg1.to_s + "  mod: " +  mod.to_s + "  target: " + target.to_s + " @healthStat: " +  @healthStat.inspect; 
         @HP[target][0] = @HP[target][0] - @dmg1 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       else;
         @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + @dmg2 + sharp).to_s + " points of damage.";
         @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - mod;     health_check(@HP[iTarget][0], @HP[iTarget][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       end;
  else;   # NATURAL 20
       if (@weapon[(@player[pIndex][12])] != "2d6") && (@weapon[(@player[pIndex][12])] != "2d4") && (@weapon[(@player[pIndex][12])] != "2d3") then;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg3.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + @dmg3 + sharp).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg3 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       else;
          @sayValue = @sayValue + "\n" + @weapon[(@player[pIndex][12])].to_s + " rolled [" + @dmg1.to_s + "][" + @dmg2.to_s + "][" + @dmg3.to_s + "][" + @dmg4.to_s + "] + " + mod.to_s + shsh + " = " + (mod + @dmg1 + @dmg2 + @dmg3 + @dmg4 + sharp).to_s + " points of damage. CRITICAL HIT!";
          @HP[target][0] = @HP[target][0] - @dmg1 - @dmg2 - @dmg3 - @dmg4 - mod;     health_check(@HP[target][0], @HP[target][1]);     @sayValue = @sayValue + "\n Creature " + iTarget + " (" + target.to_s + ") looks " + @healthStat + "\n";
       end;              
  end;
end;


######### Sharp Shooter +10 RANGE ATTACK TARGET creature #####################################
bot.message(start_with: "Srrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
      mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB -5;
      say = theUser + " made a Sharp Shooter RANGE roll to hit Creature " + target.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + "-5 = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed! \n"; puts "That was a miss.";
          else;
              say = say + "     ... HIT!"; puts "That was a hit.";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 10; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
      say = "Sharp Shooter RANGE Roll To Hit needs  Srrth?   ?= target number (0 to 9)";
    end;
    event.respond say;
end;

######### Sharp Shooter +10 damage RANGE ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "Srarth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
 #   inputStr = event.content;     length = inputStr.length;     target = inputStr.slice(6,1);     target = Integer(target) rescue false;    validInput = true;     if (length != 7) || (target == false) then;  validInput = false;  end;
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].max; result = iRoll + mod + profB - 5;
       say = theUser + " Sharp Shooter RANGE Adv roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + "-5 = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            get_Rdamages(pIndex); # go to method to get the damages
            sharp= 10; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
            say = say + @sayValue;
        end;
    else;
    say = "Sharp Shooter RANGE Adv Roll To Hit needs  Srarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### Sharp Shooter +10 damage RANGE DIS-ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "Srdrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  #  inputStr = event.content;     length = inputStr.length;     target = inputStr.slice(6,1);     target = Integer(target) rescue false;    validInput = true;     if (length != 7) || (target == false) then;  validInput = false;  end;
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   roll1=(rand 20)+1; roll2=(rand 20)+1; iRoll=[roll1,roll2].min; result = iRoll + mod + profB - 5;
       say = theUser + " Sharp Shooter RANGE DisAdv roll to hit Creature " + target.to_s + ":\n[" + roll1.to_s + "][" + roll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + "-5 = " + result.to_s;
        if (result < @armour[target]) then;
            say = say + "     ... Missed! \n";
        else;
            say = say + "     ... HIT!";
            get_Rdamages(pIndex); # go to method to get the damages
            sharp= 10; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
            say = say + @sayValue;
        end;     
    else;
    say = "Sharp Shooter RANGE DisAdv Roll To Hit needs  Srarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy RANGED ROLL TO HIT  TARGET creature #####################################
######### easy RANGED ROLL TO HIT  TARGET creature #####################################
bot.message(start_with: "rrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
 #   inputStr = event.content;     length = inputStr.length;     target = inputStr.slice(4,1);     target = Integer(target) rescue false;    validInput = true;     if (length != 5) || (target == false) then;  validInput = false;  end;
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget); puts "iTarget is: " + iTarget.inspect; puts "target is: " + target.inspect; validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];   mod2 = @player[pIndex][2];   profB=@player[pIndex][8];   mod = [mod1,mod2].max;   iRoll=(rand 20)+1; result = iRoll + mod + profB;
       say = theUser + " made a RANGED roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "      ... Missed! \n";
          else;
              say = say + "      ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "Ranged Roll To Hit needs  rrth?   ?= target number (0 to 9)";
    end;
    #event.message.delete;
    event.respond say;
end;

######### easy ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "rarth") do |event|
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
   (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
   inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
   if (validInput == true) then;
      mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1;  iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].max;  result = iRoll + mod1 + mod3 + profB;
      say = @user.to_s + " made a RANGED Advantage roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The RANGED Advantage roll to hit ... Missed!";
          else;
              say = say + "     The RANGED Advantage roll to hit ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "Ranged Advanatage Roll To Hit needs  rarth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy DISADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: "rdrth") do |event|
   if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
   (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
   inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
   if (validInput == true) then;
      mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1;  iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].min;  result = iRoll + mod1 + mod3 + profB;
      say = @user.to_s + " made a RANGED Dis-Adv roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
         if (result < @armour[target]) then;
             say = say + "     ... Missed!";
         else;
             say = say + "     ... HIT!";
             get_Rdamages(pIndex); # go to method to get the damages
             sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
             say = say + @sayValue;
         end;
   else;
       say = "RANGED Dis-Adv Roll To Hit needs  rdrth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "rbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 6) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll=(rand 20)+1; bless = (rand 4)+1; result = iRoll + mod1 + mod3 + bless + profB;
       say = @user.to_s + " made a RANGED Blessed roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll.to_s + "]+[" + bless.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed!";
          else;
              say = say + "     ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "RANGED Blessed Roll To Hit needs  rbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "rabrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1; iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].max;  bless = (rand 4)+1; result = iRoll + mod1 + mod3 + bless + profB;
       say = @user.to_s + " made a RANGED Adv Blessed roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +[" + bless.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed!";
          else;
              say = say + "     ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "RANGED Adv Blessed Roll To Hit needs  rbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy DIS-ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: "rdbrth") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
    (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
    inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(6,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end; 
    if (validInput == true) then;
       mod1 = @player[pIndex][3];  mod2 = @player[pIndex][2];  mod3 = @player[pIndex][11];  profB=@player[pIndex][8]; mod = [mod1,mod2].max; iRoll1=(rand 20)+1; iRoll2=(rand 20)+1;  iRoll=[iRoll1,iRoll2].min;  bless = (rand 4)+1; result = iRoll + mod1 + mod3 + bless + profB;
       say = @user.to_s + " made a RANGED Dis-Adv Blessed roll to hit Creature " + iTarget.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +[" + bless.to_s + "] +" + mod1.to_s + "+" + mod3.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     ... Missed!";
          else;
              say = say + "     ... HIT!";
              get_Rdamages(pIndex); # go to method to get the damages
              sharp= 0; prepare_range_damage_report(iRoll, pIndex, mod, profB, target, sharp);
              say = say + @sayValue;
          end;
    else;
       say = "RANGED Dis-Adv Blessed Roll To Hit needs  rbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ARTIFICER ATTACK TARGET creature #####################################
######### easy SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "arth") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
  if (validInput == true) then;
     spellCastMod = @player[pIndex][(@player[pIndex][10])] +1; #assigns the spell ABS mod
     abs_num_to_name(@player[pIndex][10]);           iRoll=(rand 20)+1;         profB=@player[pIndex][8]; # Assigns Proficiency Bonus 
     result = iRoll + spellCastMod + profB;  
     if (iRoll == 20) then sayHit = "The Artificer Spell attack against Creature " + iTarget.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Artificer Spell attack against Creature " + iTarget.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a (" + @ABSname + ") SPELL attack: [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Artificer Spell attack Missed!";
        else;
            say = say + sayHit; 
        end;
     else;
       say = "Roll To Hit needs  arth?   ?= target (A,B,C ...)";
     end;    
        event.respond say;
end;
######### Artificer Companion ATTACK TARGET creature #####################################
######### Artificer Companion ATTACK TARGET creature #####################################
bot.message(start_with: "comp") do |event|
  theUser = "COMP!"; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
  if (validInput == true) then;
     iRoll=(rand 20)+1;      mod1 = @player[pIndex][2];     profB=@player[pIndex][8]; # Assigns Proficiency Bonus 
     result = iRoll + profB + mod1;  
     if (iRoll == 20) then sayHit = "The Artificer Companion melee against Creature " + iTarget.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Artificer Companion attack against Creature " + iTarget.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a melee attack: [" + iRoll.to_s + "] +" + mod1.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Artificer Companion attack Missed!";
        else;
            say = say + sayHit; 
        end;
     else;
       say = "Artificer COMPanion needs  comp?   ?= target (A,B,C ...)";
     end;    
        event.respond say;
end;

######### easy SPELL ATTACK TARGET creature #####################################
######### easy SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "srth") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(4,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 5) || (target == nil) then;  validInput = false;  end; 
  if (validInput == true) then;
     spellCastMod = @player[pIndex][(@player[pIndex][10])]; #assigns the spell ABS mod
     abs_num_to_name(@player[pIndex][10]);           iRoll=(rand 20)+1;         profB=@player[pIndex][8]; # Assigns Proficiency Bonus 
     result = iRoll + spellCastMod + profB;  
     if (iRoll == 20) then sayHit = "The SPELL attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The SPELL attack against Creature " + target.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a (" + @ABSname + ") SPELL attack: [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The SPELL attack Missed!";
        else;
            say = say + sayHit; 
        end;
     else;
       say = "Spell Roll To Hit needs  srth?   ?= target number (0 to 9)";
     end;    
        event.respond say;
end;

######### easy ADVANTAGE SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "sarth") do |event|
    inputValue = event.content;
    target = Integer(inputValue.slice(5,1)) rescue false;
    if ( target!= false ) then;
        if event.user.nick != nil;
           theUser = event.user.nick;
        else;
           theUser = event.user.name;
        end;
        pIndex = nil;
        (0..(@player.length-1)).each do |y|
            if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
        end;
        spellCastMod = @player[pIndex][(@player[pIndex][10])]; #assigns the spell ABS mod 
        profB=@player[pIndex][8]; # Assigns Proficiency Bonus
        iRoll1 = (rand 20)+1;  iRoll2 = (rand 20)+1;    iRoll= [iRoll1,iRoll2].max;
        result = iRoll + spellCastMod + profB;
        if (iRoll == 20) then sayHit = "The SPELL Advantage attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The SPELL Advantage attack against Creature " + target.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled an SPELL Advantage attack: [" + iRoll1.to_s + "][" + iRoll2.to_s + "]    [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The SPELL Advantage attack Missed!";
        else;
            say = say + sayHit; 
        end;
    else;
      say = "SPELL Advantage Roll To Hit needs  sarth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;

######### easy DISADVANTAGE SPELL ATTACK TARGET creature #####################################
bot.message(start_with: "sdrth") do |event|
    inputValue = event.content;
    target = Integer(inputValue.slice(5,1)) rescue false;
    if ( target!= false ) then;
        if event.user.nick != nil;
           theUser = event.user.nick;
        else;
           theUser = event.user.name;
        end;
        pIndex = nil;
        (0..(@player.length-1)).each do |y|
            if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
        end;
        spellCastMod = @player[pIndex][(@player[pIndex][10])]; #assigns the spell ABS mod 
        profB=@player[pIndex][8]; # Assigns Proficiency Bonus
        iRoll1 = (rand 20)+1;  iRoll2 = (rand 20)+1;    iRoll= [iRoll1,iRoll2].min;
        result = iRoll + spellCastMod + profB;
        if (iRoll == 20) then sayHit = "The Dis-Advantage SPELL attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Dis-Advantage SPELL attack against Creature " + target.to_s + "   HIT!" end;
        say = theUser.to_s + " rolled an Dis-Advantage SPELL attack: [" + iRoll1.to_s + "][" + iRoll2.to_s + "]    [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Dis-Advantage SPELL attack Missed!";
        else;
            say = say + sayHit; 
        end;
    else;
      say = "SPELL Advantage Roll To Hit  sdrth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;

#######################################################
#######################################################
########## DAMAGE Sneak Attack Dagger d4 ##############
bot.message(start_with: "SAD2") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2];
       (0..1).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (2 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;


########## DAMAGE Sneak Attack Dagger d4 CRITICAL ##############
bot.message(start_with: "!SAD2") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..3).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (2 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 ##############
bot.message(start_with: "SAD3") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (3 dice ) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 CRITICAL ##############
bot.message(start_with: "!SAD3") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (3 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: "SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3];
       (0..3).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (4 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: "!SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5,6,7];
       (0..7).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (4 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + 
                                                                dDie[4].to_s + "][" + dDie[5].to_s + "][" + dDie[6].to_s + "][" + dDie[7].to_s +  "] = " + totalDmg.to_s;

  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: "SAD5") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4];
       (0..4).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (5 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: "!SAD5") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5,6,7,8,9];
       (0..9).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (5 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + 
                                    dDie[4].to_s + "][" + dDie[5].to_s + "][" + dDie[6].to_s + "][" + dDie[7].to_s +  "][" + dDie[8].to_s +  "][" + dDie[8].to_s +  "] = " + totalDmg.to_s;

  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: "SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (6 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s + "] = " + totalDmg.to_s;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: "!SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
       totalDmg=0;
       dDie = [0,1,2,3,4,5,6,7,8,9,10,11];
       (0..11).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (6 dice) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" +
                                      dDie[5].to_s + "][" + dDie[6].to_s + "][" + dDie[7].to_s +  "][" + dDie[8].to_s +  "][" + dDie[9].to_s + "][" + dDie[10].to_s + "][" + dDie[10].to_s + "] = " + totalDmg.to_s;

  event.respond responseValue;
end;

######### Ability Score Damage ######
bot.message(start_with: "absdmg") do |event|;
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  dmgRoll = (rand 10)+1;
  case dmgRoll;
    when 1..4; damage =1;
    when 5..7; damage =2;
    when 8..9; damage =3;
    when 10; damage =4;
  end;
    responseValue = @user.to_s + " Constitution Score Damage value is: " + damage.to_s;
    event.respond responseValue;
end;



########## SHILLELAGH ##############
bot.message(start_with: "shill") do |event|;
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputStr = event.content;  length = inputStr.length;  iTarget = inputStr.slice(5,1);  target = "ABCDEFGHIJKLMNOPQRSTU".index(iTarget);  validInput = true; if (length != 7) || (target == nil) then;  validInput = false;  end; 
  if validInput == true then;
    case inputStr.slice(6,1); when "I"; abs=5; when "W"; abs=6; when "C"; abs=7; end;
    roll2hit = (rand 20) +1; profB = @player[pIndex][8]; absMod = @player[pIndex][abs]; final2hit = roll2hit + profB + absMod;  
    targetAC= @armour[target];
       responseValue = @user.to_s + " Shillelagh roll to hit: " + roll2hit.to_s + " (" + profB.to_s + "+" + absMod.to_s + ") = " + final2hit.to_s;
    else;
      responseValue = "Sorry, shill needs shill?$, where ? = target (ABC..) and $ = stat (Int, Wis, Char)";
    end;
    event.respond responseValue;
end;




########## DAMAGE Grave Bolt ##############
bot.message(start_with: ";GB") do |event|
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
bot.message(start_with: ";BB") do |event|
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
bot.message(start_with: ";FB") do |event|
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
bot.message(start_with: ";SG") do |event|
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
bot.message(start_with: ";TD") do |event|
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
bot.message(start_with: ";CO") do |event|
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
bot.message(start_with: ";DB") do |event|
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
bot.message(start_with: ";MM") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2,3]; totalDmg=0;
         (0..3).each do |x|;
              dDie[x]=(rand 4)+1;
              totalDmg=totalDmg + dDie[x] + 4;
         end;
         lesserDmg = totalDmg - dDie[3] -1;
         responseValue = @user.to_s + " Magic Missile damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] +3 = " + lesserDmg.to_s + "\nUp Cast damage would add [" + dDie[3].to_s + "] +1 = " + totalDmg.to_s;
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Aganazzar's Scorcher ##############
bot.message(start_with: ";AS") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Za") || (@user.slice(0,2) == "Al") then
         dDie = [0,1,2]; totalDmg=0;
         (0..2).each do |x|;
              dDie[x]=(rand 8)+1;
              totalDmg=totalDmg + dDie[x];;
         end;
         responseValue = @user.to_s + " Aganazzar's Scorcher damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s + "\nTarget makes a DEX save to take half damage";
    else;
      responseValue = "Sorry, you cannot cause this damage type."
    end;
    event.respond responseValue;
end;

########## DAMAGE Scorching Ray ##############
bot.message(start_with: ";SR") do |event|
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
bot.message(start_with: ";ACID") do |event|
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
bot.message(start_with: ";!ACID") do |event|
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
bot.message(start_with: ";AFIRE") do |event|
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
bot.message(start_with: ";!AFIRE") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
         dDie = [0,1]; totalDmg=0;
         dDie[0]=(rand 4)+1; dDie[1]=(rand 4)+1;
         totalDmg=totalDmg + dDie[0] + dDie[1];
         responseValue = @user.to_s + " has used Alchemical Fire with a Critical Hit: [" + dDie[0].to_s + "][" + dDie[1].to_s + "] = " + totalDmg.to_s; + 
                                      "\nTarget keeps burning (burn baby, burn) until they use their action to extinguish the flames (DC10 Dex)";
    event.respond responseValue;
end;

##########  Heat Metal 2 ##############
bot.message(start_with: "heatmetal2") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; totalDmg = theRoll1 + theRoll2;
  say = theUser.to_s + " has used\nHEAT METAL to cause (2d8) damage. CONSTITUTION saving throw...";
  say = say + "\nOn a save a hot object may be held and used at DisAdvantage. (full damage regardless).";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;

##########  Heat Metal 3 ##############
bot.message(start_with: "heatmetal3") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; theRoll3 = (rand 8)+1; totalDmg = theRoll1 + theRoll2 + theRoll3;
  say = theUser.to_s + " has used\nHEAT METAL to cause (3d8) damage. CONSTITUTION saving throw...";
  say = say + "\nOn a save a hot object may be held and used at DisAdvantage. (full damage regardless).";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] + [" + theRoll3.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;

##########  Thunder Wave ##############
bot.message(start_with: "thunderwave2") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; totalDmg = theRoll1 + theRoll2;
  say = theUser.to_s + " has used\nTHUNDERWAVE to cause (2d8) damage. CONSTITUTION saving throw.";
  say = say + "\nOn a failed save they will be pushed 10 ft away from caster.";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;

##########  Thunder Wave 3##############
bot.message(start_with: "thunderwave3") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  theRoll1 = (rand 8)+1; theRoll2 = (rand 8)+1; theRoll3 = (rand 8)+1; totalDmg = theRoll1 + theRoll2 + theRoll3;
  say = theUser.to_s + " has used\nTHUNDERWAVE to cause (3d8) damage. CONSTITUTION saving throw.";
  say = say + "\nOn a failed save they will be pushed 10 ft away from caster.";
  say = say +  "\n[" + theRoll1.to_s +  "] + [" + theRoll2.to_s + "] + [" + theRoll3.to_s + "] = " + totalDmg.to_s + "  of damage.";
  event.respond say;
end;
##########  Healing Word ##############
bot.message(start_with: "healingword") do |event|
  if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end; pIndex = nil;  # get value for theUser set pIndex for next line of code
  (0..(@player.length-1)).each do |y|; if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end;  end; #finds player Index Value (integer or nil)
  inputValue = event.content;
  absMod = @player[pIndex][6];
  theRoll = (rand 4)+1; totalHeal = theRoll + absMod;
  responseValue = theUser.to_s + " has used\nHealing Word (1d4) to heal someone for: [" + theRoll.to_s +  "] + " + absMod.to_s + " = " + totalHeal.to_s + " HP";
  event.respond responseValue;
end;

################## g20. gm roll d20  ##########################
bot.message(contains:"g20.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;   
    parse_the_d("g20.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " g20. requires  g20.  OR   ?g20.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d20 " + " + ?\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 20)+1+@gmBonus;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       say = say + "   REASON: " + comment;
       say = say + "\n= = = = = = = = = = = = = = =";
       event.message.delete;  
    end;
    event.respond say;
end;


################## d24. ##########################
bot.message(contains:"d24.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;   
    parse_the_d("d24.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d24. requires  ?d24.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d24 " ++ " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 24)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "\nREASON: " + comment;
    end;
    event.respond say;
end;

################## d100. ##########################
bot.message(contains:"d100.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    parse_the_d("d100.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d100. requires  d100.  OR   ?d100.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d100" + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 100)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "  REASON: " + comment;
       say = say + "\n- - - - - - - - - - - - - -";
    end;
    event.respond say;
end;

################## d500. ##########################
bot.message(contains:"d500.") do |event|
    event.message.delete;
    check_user_or_nick(event);      @tempVar = event.content;   comment = "Unknown"
    blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    parse_the_d("d500.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d500. requires  d500.  OR   ?d500.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d500" + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 500)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
       say = say + "\nREASON: " + comment;
    end;
    event.respond say;
end;

################## D500. ##########################
################## D500. ##########################
################## D500. ##########################
################## D500. ##########################
################## D500. ##########################
bot.message(contains:"D500.") do |event|
    event.message.delete;  say = "SHIT";
    check_user_or_nick(event);  @tempVar = event.content;  comment = "Unknown";  blank = @tempVar.index(' ');
    if blank != nil then;
      comment = @tempVar.slice(blank,99);
      @tempVar = @tempVar.slice(0,blank);
    end;
    locationValue = @tempVar.index('D500.');
    chkNum = Integer(locationValue) rescue false;
    if ( chkNum == false ) then;
      say = "Busted: " + chkNum.to_s;
    else;
         if chkNum > 0 then;
            howManyDice = @tempVar.slice(0,(locationValue.to_i));
            puts howManyDice.to_s + "     <----";
            say = @user.to_s + " rolled " + howManyDice.to_s + "D500." + " + " + @whatPlus.to_s + "\n";
            die=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; total=0;
            (0..(howManyDice.to_i)).each do |x|;
               die[x]=(rand 500)+1;
               say = say + "[" + die[x].to_s + "]";
               total=total + die[x];
            end;
            total = total + @whatPlus;
            say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
            say = say + "\nREASON: " + comment;
         else;
            say = "Only rolled one."
         end;      
    end;
    event.respond say;
end;


####### parse_the_d accepts and incoming value of something like d20. to help location the core of the command
def parse_the_d(incoming);
  #puts "the value of @tempVar is: " + @tempVar.inspect;
  theIndex1 = @tempVar.index(incoming).to_i;          #puts "The Index Value: " + theIndex1.to_s;
  if theIndex1 == false then; theIndex1 = 1; end;     #puts " the value of theIndex1 is: " + theIndex1.inspect;
  @howManyDice = Integer(@tempVar.slice(0,(theIndex1))) rescue false;
  if @howManyDice == false then; @howManyDice = 1; end; #puts "the value of @howManyDice is: " + @howManyDice.inspect;
  if ( @howManyDice == "0" || @howManyDice == "" ) then @howManyDice = 1; end; #puts "the value of @tempVar is: " + @tempVar.inspect;
  theIndex2 = @tempVar.index('.');         #puts "the value of theIndex2 is: " + theIndex2.inspect;
  tempVarLen = @tempVar.length;            #puts "the value of tempVarLen  is: " + tempVarLen.inspect;
  if @tempVar.slice((theIndex2+1),1) != nil then;
     @whatPlus = @tempVar.slice((theIndex2+1),(tempVarLen-theIndex2));
  else 
    @whatPlus = 0;
  end;
  validate_integer(@whatPlus);
  if @intVal == false then; 
     @whatPlus = 0;
  else;
    @whatPlus = Integer(@whatPlus);
  end;
end;

#########################################
###########  WEAPONS  ##############
#########################################
bot.message(start_with:"$Wlist") do |event|
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;  pIndex = nil;
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    say = "Greetings, " + theUser + "\n";
    say = say + "Your MELEE weapon damage: " + @weapon[(@player[pIndex][1])].to_s + "\n";
    say = say + "Your RANGED weapon damage: " + @weapon[(@player[pIndex][12])].to_s + "\n";
    say = say +  "To change use   $Mset? (melee)   or   $Rset?  (ranged)  \n";
    say = say +  "where ? is an Integer, as shown below. ($Mset3  or  $Rset3)  \n\n";
    (0..7).each do |x|;
          say = say + "[" + @weapon[x] + " = " + x.to_s  + "]   ";
    end;                 
    event.respond say;
end;

bot.message(start_with:"$Mset") do |event|
    inputStr = event.content; # this should contain "$Wset#" where # is a single digit
    if event.user.nick != nil
      theUser = event.user.nick
    else
      theUser = event.user.name
    end
    pIndex = nil;  #fetch the value of @user & set pIndex
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    weaponInt = Integer(inputStr.slice(5,1)) rescue false; #will detect integer or non integer input
    if (pIndex != nil) && (weaponInt != false) && (weaponInt < 8) then; 
           @player[pIndex][1]=weaponInt;
           say = theUser.to_s + " MELEE weapon damage has been set to " + @weapon[(@player[pIndex][1])].to_s;
    else
       say = "Please try: $Mset?  where ? is a single number ( 0 to 5 )"; 
    end;
    event.respond say;
end;

bot.message(start_with:"$Rset") do |event|
    inputStr = event.content; # this should contain "$Wset#" where # is a single digit
    if event.user.nick != nil
      theUser = event.user.nick
    else
      theUser = event.user.name
    end
    pIndex = nil;  #fetch the value of @user & set pIndex
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    weaponInt = Integer(inputStr.slice(5,1)) rescue false; #will detect integer or non integer input
    if (pIndex != nil) && (weaponInt != false) && (weaponInt < 8) then; 
           @player[pIndex][12]=weaponInt;
           say = theUser.to_s + " RANGED weapon damage has been set to " + @weapon[(@player[pIndex][12])].to_s;
    else
       say = "Please try: $Mset?  where ? is a single number ( 0 to 5 )"; 
    end;
    event.respond say;
end;

####### GET THE PLAYER INDEX ##########
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

#########################################
###########  Armour Class  ##############
#########################################
bot.message(start_with:"$AClist") do |event|
    check_user_or_nick(event); say = "";
    if @user.slice(0,5) == "Allen" then; # as long as the user is Allen, perform the following
            (0..19).each do |x|;
                acVal = @armour[x].to_s;
                alphaVal = "ABCDEFGHIJKLMNOPQRSTU"[x];
                say = say + "Creature " + alphaVal + "  (" + x.to_s + ")  currently has " + acVal + " Armour Class. \n";
            end;           
    end;
    event.respond say;
end;

bot.message(start_with:"$ACset") do |event|
    check_user_or_nick(event);
    creatAC= false;
    inputStr = event.content.slice(6,3);   # creature Number and AC should be in the string
    strLength = inputStr.length;
    creatNum = inputStr.slice(0,1); 
    if strLength == 3 then;
       creatAC = inputStr.slice(1,2); 
    end;
    if strLength == 2 then;
       creatAC = inputStr.slice(1,1);
    end;
    cNum = Integer(creatNum) rescue false; #creature Number
    acVal = Integer(creatAC) rescue false;  #Value of AC
    if (  (cNum != false) && (acVal != false) && (@user.slice(0,5) == "Allen") ) then;
          @armour[cNum]=acVal;
          say = "Armour Class for Creature " + cNum.to_s + " was set to AC: " + acVal.to_s;
    else;
      say = @user.to_s + " , these is something wrong. \n cNum:" + cNum.to_s + " acVal:" + acVal.to_s + " inputStr:" + inputStr.to_s;   
      say = say + "  input length:" + (inputStr.length).to_s;
    end;
    event.respond say;
end;

bot.message(start_with:"$ACall") do |event|
    check_user_or_nick(event);
    theString = event.content;
    acVal = Integer(theString.slice(6,2)) rescue false
    if ( (@user.slice(0,5) == "Allen") && (acVal != false) ) then;
             (0..19).each do |x|;
                  @armour[x]=acVal.to_i;
             end;
             say = "ALL creatures now have an AC of: " + acVal.to_s;
    else;     
     say = @user.to_s + ", Something isn't right:" + acVal.to_s;
    end;
    event.respond  say;
end;


bot.message(start_with:"$HPlist") do |event|
    check_user_or_nick(event); say = "";
    if @user.slice(0,5) == "Allen" then; # as long as the user is Allen, perform the following
            (0..19).each do |x|;
                hpVal = @HP[x][0].to_s;
                alphaVal = "ABCDEFGHIJKLMNOPQRSTU"[x];
                say = say + "Creature " + alphaVal + "  (" + x.to_s + ")  currently has " + hpVal + " hit points. \n";
            end;           
    end;
    event.respond say;
end;

bot.message(start_with:"$HPset") do |event|
    check_user_or_nick(event);
    inputStr = event.content.slice(6,4);   # creature Number and AC should be in the string
    creatNum = inputStr.slice(0,1); creatHP = inputStr.slice(1,3); 
    cNum = Integer(creatNum) rescue false; #creature Number
    hpVal = Integer(creatHP) rescue false;  #Value of HP
    if ( (inputStr.length > 1) && (cNum != false) && (hpVal != false) && (@user.slice(0,5) == "Allen") ) then;
          @HP[cNum][0]=hpVal;  @HP[cNum][1]= hpVal + 0.0;
          say = "Hit Points for Creature " + cNum.to_s + " was set to: " + hpVal.to_s + "  " + (hpVal + 0.0).to_s;
    else;
      say = @user.to_s + "$HPset?? where first ? is Target Integer and second ? is the HP integers."
    end;
    event.respond say;
end;

bot.message(start_with:"$HPall") do |event|
    check_user_or_nick(event);  theString = event.content;
    hpVal = Integer(theString.slice(6,3)) rescue false
    if ( (@user.slice(0,5) == "Allen") && (hpVal != false) ) then;
             (0..19).each do |x|;
                  @HP[x][0]=hpVal.to_i;
                  @HP[x][1]=(hpVal.to_i)+0.1;
             end;
             say = "ALL creatures now have HP of: " + hpVal.to_s;
    else;     
     say = @user.to_s + ", Something isn't right:" + hpVal.to_s;
    end;
    event.respond  say;
end;


################# Character Generator #########################
bot.message(start_with:"charGen") do |event|
    check_user_or_nick(event); say="";
    results = [0,0,0,0,0,0];   rolls = [0,0,0,0];   bigTotal = 0; total = 0;
       (0..5).each do |z|;
            (0..3).each do |y|;
               rolls[y]= SecureRandom.random_number(6)+1;
               total = total + rolls[y];
            end;
            minimum = rolls.min;
            results[z] = rolls[0]+rolls[1]+rolls[2]+rolls[3]-minimum;
            bigTotal = bigTotal + results[z]; 
            say = say + "[" + rolls[0].to_s + "]" + "[" + rolls[1].to_s + "]" + "[" + rolls[2].to_s + "]" + "[" + rolls[3].to_s + "]" + " = " + results[z].to_s + "\n";
       end;
       say = say + "Average: " + ('%.2f' % (bigTotal/6.0)).to_s; 
    event.respond say;
end;


################## RELENTLESS ENDURANCE ###############################
bot.message(start_with:"RELE") do |event|
    check_user_or_nick(event);
       inputStr = event.content.slice(4,1);   # creature Number and DAMAGE should be in the string
       creatNum = Integer(inputStr.slice(0,1));
       @RE[creatNum] = 1;
       say = "creature " + creatNum.to_s + " Relentless Endurance reset to 1.";
    event.respond say;
end;


########## CHAOS 
bot.message(start_with:"boon") do |event|
  say = ""
    if event.user.nick != nil; theUser = event.user.nick; else; theUser = event.user.name; end;
    timeText = (DateTime.now).to_s;
    hour = timeText.slice(11,2);
    min = timeText.slice(14,2);    
    if ( hour == "12") && (min.to_i < 56) then;
       result = rand 11;
       case result;
           when 0; say = say + "You have two (2) additional recovery Hit Dice until you long rest.";
           when 1; say = say + "You have +2 on all saving throws until you long rest.";
           when 2; say = say + "You do +2 damage on all hits until you roll a Natural 20."
           when 3; say = say + "You get +2 on all heal dice until you long rest."
           when 4; say = say + "You may re-roll 1 on a SAVE or SKILL check until you long rest."
           when 5; say = say + "You add +2 to all SKILL checks until you long rest."
           when 6; say = say + "You roll with advantage on SKILL checks until you long rest."
           when 7; say = say + "You may re-roll all the one (1) values on MELEE damage rolls until you long rest."
           when 8; say = say + "You have INSPIRATION X 5.";
           when 9; say = say + "You have three (3) automatic hits for this game." 
           when 10; say = say + "Your character is able to cast SCORCHING RAY (+7 to hit) three (3) times this game." 
       end;
       say = "This boon replaces any and all previous boons.\n" + theUser + ", your Boon is " + say;
     else
       say = "The time is " + hour + ":" + min + " the Boon opportunity ended at 12:55 am"
     end;
    event.respond say;
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

######## ABS score modifier is asigned a name
def abs_num_to_name(numb)
  case numb
      when 2; @ABSname = "Strength";
      when 3; @ABSname = "Dexterity";
      when 4; @ABSname = "Constitution";
      when 5; @ABSname = "Intelligence";
      when 6; @ABSname = "Wisdom";
      when 7; @ABSname = "Charisma";
  end;
end;


def roll_damage(damType);
  case damType;
     when "2d6"; @damage1 = (rand 6)+1; @damage2 = (rand 6)+1; @damage3 = (rand 6)+1; @damage4 = (rand 6)+1;
     when "1d12"; @damage1 = (rand 12)+1; @damage2 = -99; @damage3 = (rand 12)+1; @damage4 = -99;
     when "1d10"; @damage1 = (rand 10)+1; @damage2 = -99; @damage3 = (rand 10)+1; @damage4 = -99;
     when "1d8"; @damage1 = (rand 8)+1; @damage2 = -99; @damage3 = (rand 8)+1; @damage4 = -99;
     when "1d6"; @damage1 = (rand 6)+1; @damage2 = -99; @damage3 = (rand 6)+1; @damage4 = -99;
     when "1d4"; @damage1 = (rand 4)+1; @damage2 = -99; @damage3 = (rand 4)+1; @damage4 = -99;
     when "2d4"; @damage1 = (rand 4)+1; @damage2 = (rand 4)+1; @damage3 = (rand 4)+1; @damage4 = (rand 4)+1;
  end;
end;


bot.run