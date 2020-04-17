#
require 'discordrb'
require 'yaml'


#####Configuration########
junk = YAML.load(File.read("data.yml"));
token = junk[0]+junk[1]+junk[2];

prefix = "!" # Your bot's prefix
owner = 690339632529015005 # Your user ID

@armour = YAML.load(File.read("armourClass.yml"));
@HP = YAML.load(File.read("hitPoints.yml"));
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

################################
######## HEALTH CHECK ##########
def health_check(currentHp, originalHp);
  perCent = currentHp/originalHp;
  if perCent < 0.00010 then; @healthStat = "Dead"; end;  # less than 0.0001 is only possible when HP = 0 or less 
  if perCent > 0.00000 then; @healthStat = "Deformed"; end;
  if perCent > 0.24999 then; @healthStat = "Bloodied"; end;
  if perCent > 0.49999 then; @healthStat = "Injured"; end;
  if perCent > 0.74999 then; @healthStat = "Healthy"; end;
end;

bot = Discordrb::Bot.new token: token 

bot.message(start_with: ";deleteme") do |event|;
      say = "The Message ID was: " + event.message.id.to_s;
      say = say + "\nThe Author ID was: " + event.author.id.to_s;
      say = say + "\nThe Autthor name was: " + event.author.username.to_s
#      say = say + "\n" + event.author.discriminator.to_s
#      say = say + "\n" + event.author.server.name.to_s
#      say = say + "\n" + event.author.server.id.to_s
#      say = say + "\n" + event.channel.inspect.to_s
#      say = say + "\n" + event.content.to_s;
#      say = say + "\n" + event.file.to_s;
#      say = say + "\n" + event.message.to_s;
#      say = say + "\n" + event.saved_message.to_s;
#      say = say + "\n" + event.server.to_s;    
#      say = say + "\n" + event.timestamp.to_s;
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
    if inputValue == ";i"; then;
       responseValue = "@everyone Please roll initiative with command:   ;init \n"+
                      "(The bot knows your character ability score modifiers.)";
       event.respond responseValue;
    end;
end;

########## Unique INITIATIVE ########
bot.message(start_with: ";init") do |event|
    if event.user.nick != nil
        theUser = event.user.nick
    else
        theUser = event.user.name
    end;
    inputValue = event.content;
    pIndex = nil;
    (0..(@player.length-1)).each do |y|
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    mod = @player[pIndex][3]+@player[pIndex][9];
    initRoll=(rand 20)+1;
    result = initRoll + mod;
    responseValue = theUser.to_s + " has rolled initiative: [" + initRoll.to_s + "] + " + mod.to_s + " = " + result.to_s;
    event.message.delete;
    event.respond responseValue;
end;

########## Advantage Unique INITIATIVE ########
bot.message(start_with: ";ainit") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    get_the_player();
    mod = @player[@playerIndex][3];
    initRoll1=(rand 20)+1;    
    initRoll2=(rand 20)+1;
    initRoll = [initRoll1,initRoll2].max;
    result = initRoll + mod;
    responseValue = @user.to_s + " has rolled initiative with ADVANTAGE: [" + initRoll1.to_s + "][" + initRoll2.to_s + "] + "  + mod.to_s + " = " + result.to_s;
    event.message.delete;
    event.respond responseValue;
end;

########## DisAdvantage Unique INITIATIVE ########
bot.message(start_with: ";dinit") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    get_the_player();
    mod = @player[@playerIndex][3];
    initRoll1=(rand 20)+1;    
    initRoll2=(rand 20)+1;
    initRoll = [initRoll1,initRoll2].min;
    result = initRoll + mod;
    responseValue = @user.to_s + " has rolled initiative with DIS-ADVANTAGE: [" + initRoll1.to_s + "][" + initRoll2.to_s + "] + "  + mod.to_s + " = " + result.to_s;
    event.message.delete;
    event.respond responseValue;
end;

######### easy ATTACK TARGET creature #####################################
bot.message(start_with: ";rth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheRTH(inputValue); #standard validation process found up top
    if (@valTheRTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];      profB=@player[@playerIndex][8];
      mod = [mod1,mod2].max;
      str_2_number(inputValue.slice(4,1)); target = @numba # @numba <= is the result
      iRoll=(rand 20)+1; result = iRoll + mod + profB;
      say = @user.to_s + " rolled an attack against Creature " + target.to_s + ":\n[" + iRoll.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The attack Missed! \n";
          else;
              say = say + "     The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              thePlayerIndex = @playerIndex;
              theWeaponIndex = @player[@playerIndex][1];
              theDamageRoll = @weapon[(@player[@playerIndex][1])];
              roll_damage(@weapon[(@player[@playerIndex][1])]); #damage die type in @player
              #@damage & @damage1 now have values
              if iRoll != 20 then;
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                     #say = say + "\n P-Index:" + thePlayerIndex.to_s +  "    W-Index:" + theWeaponIndex.to_s + "   theDamage:" + theDamageRoll.to_s + "\n";
                     say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1).to_s + " points of damage.";
                     @HP[target][0] = @HP[target][0] - @damage1 - mod;
                     health_check(@HP[target][0], @HP[target][1])
                     say = say + "\n Creature " + target.to_s + " looks " + @healthStat + "\n";
                   else;
                     #say = say + "\n P-Index:" + thePlayerIndex.to_s +  "    W-Index:" + theWeaponIndex.to_s + "   theDamage:" + theDamageRoll.to_s + "\n";
                     say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] [" + @damage2.to_s + "] + " +
                                  mod.to_s + " = " + (mod + @damage1 + @damage2).to_s + " points of damage.";
                     @HP[target][0] = @HP[target][0] - @damage1 - @damage2 - mod;
                     health_check(@HP[target][0], @HP[target][1])
                     say = say + "\n Creature " + target.to_s + " looks " + @healthStat + "\n";
                   end;
              else
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage3.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1 + @damage3).to_s + " points of damage. CRITICAL HIT!";
                      @HP[target][0] = @HP[target][0] - @damage1 - @damage3 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature " + target.to_s + " looks " + @healthStat + "\n";
                                  
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "][" + @damage3.to_s +
                                 "][" + @damage4.to_s + "] + " + mod.to_s + " = " + (mod + @damage1 + @damage2 + @damage3 + @damage4).to_s + " points of damage. CRITICAL HIT!";
                      @HP[target][0] = @HP[target][0] - @damage1 - @damage2 - @damage3 - @damage4 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature " + target.to_s + " looks " + @healthStat + "\n";
                   end;              
              end;
          end;
    else;
       say = "Roll To Hit needs  ;rth?   ?= target number (0 to 9)";
    end;
    #event.message.delete;
    event.respond say;
end;

######### easy ADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: ";arth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheARTH(inputValue); #standard validation process found up top
    if (@valTheARTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];      profB=@player[@playerIndex][8];
      mod = [mod1,mod2].max;
      str_2_number(inputValue.slice(5,1)); target = @numba # @numba <= is the result
      iRoll1=(rand 20)+1;  iRoll2=(rand 20)+1;
      iRoll=[iRoll1,iRoll2].max;
      result = iRoll + mod + profB;
      say = @user.to_s + " rolled an ADVANTAGE attack against Creature " + target.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The attack Missed!";
          else;
              say = say + "     The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              roll_damage(@weapon[(@player[@playerIndex][1])]); #damage die type in @player
              #@damage & @damage1 now have values
              if iRoll != 20 then;
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1).to_s + " points of damage.";
                      @HP[target][0] = @HP[target][0] - @damage1 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;                                  
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] [" + @damage2.to_s + "] + " +
                                  mod.to_s + " = " + (mod + @damage1 + @damage2).to_s + " points of damage.";
                      @HP[target][0] = @HP[target][0] - @damage1 - @damage2 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;
                   end;
              else
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage3.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1 + @damage3).to_s + " points of damage. CRITICAL HIT!";
                      @HP[target][0] = @HP[target][0] - @damage1 - @damage3 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "][" + @damage3.to_s +
                                 "][" + @damage4.to_s + "] + " + mod.to_s + " = " + (mod + @damage1 + @damage2 + @damage3 + @damage4).to_s + " points of damage. CRITICAL HIT!";
                      @HP[target][0] = @HP[target][0] - @damage1 - @damage2 - @damage3 - @damage4 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;
                   end;              
              end;
          end;
          
    else;
       say = "Advanatage Roll To Hit needs  ;arth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy DISADVANTAGE ATTACK TARGET creature #####################################
bot.message(start_with: ";drth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheARTH(inputValue); #standard validation process found up top
    if (@valTheARTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];      profB=@player[@playerIndex][8];
      mod = [mod1,mod2].max;
      str_2_number(inputValue.slice(5,1)); target = @numba # @numba <= is the result
      iRoll1=(rand 20)+1;  iRoll2=(rand 20)+1;
      iRoll=[iRoll1,iRoll2].min;
      result = iRoll + mod + profB;
      say = @user.to_s + " rolled an DISADVANTAGE attack against Creature " + target.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The attack Missed!";
          else;
              say = say + "     The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              roll_damage(@weapon[(@player[@playerIndex][1])]); #damage die type in @player
              #@damage & @damage1 now have values
              if iRoll != 20 then;
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1).to_s + " points of damage.";
                      @HP[target][0] = @HP[target][0] - @damage1 - mod;
                      health_check(@HP[target][0], @HP[target][1])
                      say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;                                  
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] [" + @damage2.to_s + "] + " +
                                  mod.to_s + " = " + (mod + @damage1 + @damage2).to_s + " points of damage.";
                                  @HP[target][0] = @HP[target][0] - @damage1 - @damage2 - mod;
                                  health_check(@HP[target][0], @HP[target][1])
                                  say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;
                   end;
              else
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage3.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1 + @damage3).to_s + " points of damage. CRITICAL HIT!";
                                  @HP[target][0] = @HP[target][0] - @damage1 - @damage3 - mod;
                                  health_check(@HP[target][0], @HP[target][1])
                                  say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "][" + @damage3.to_s +
                                 "][" + @damage4.to_s + "] + " + mod.to_s + " = " + (mod + @damage1 + @damage2 + @damage3 + @damage4).to_s + " points of damage. CRITICAL HIT!";
                                 @HP[target][0] = @HP[target][0] - @damage1 - @damage2 - @damage3 - @damage4 - mod;
                                 health_check(@HP[target][0], @HP[target][1])
                                 say = say + "\n Creature Number " + target.to_s + " looks " + @healthStat;
                   end;              
              end;
          end;
          
    else;
       say = "Dis-Advanatage Roll To Hit needs  ;drth?   ?= target number (0 to 9)";
    end;    
    event.respond say;
end;


######### easy BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: ";brth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheBRTH(inputValue); #standard validation process found up top
    if (@valTheBRTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];     profB=@player[@playerIndex][8];
      mod = [mod1,mod2].max;
      str_2_number(inputValue.slice(5,1)); target = @numba # @numba <= is the result
      blessDie = (rand 4)+1;
      iRoll=(rand 20)+1; result = iRoll + mod + profB + blessDie;
      say = @user.to_s + " rolled a Blessed attack against Creature " + target.to_s + ":\n[" + iRoll.to_s + "]  [" + blessDie.to_s + "]  +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The attack Missed!";
          else;
              say = say + "     The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              roll_damage(@weapon[(@player[@playerIndex][1])]); #damage die type in @player
              #@damage & @damage1 now have values
              if iRoll != 20 then;
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1).to_s + " points of damage.";
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "] + " +
                                  mod.to_s + " = " + (mod + @damage1 + @damage2).to_s + " points of damage.";
                   end;
              else
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage3.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1 + @damage3).to_s + " points of damage. CRITICAL HIT!";
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "][" + @damage3.to_s +
                                 "][" + @damage4.to_s + "] + " + mod.to_s + " = " + (mod + @damage1 + @damage2 + @damage3 + @damage4).to_s + " points of damage. CRITICAL HIT!";
                   end;              
              end;
          end;
          
    else;
       say = "Blessed Roll To Hit needs  ;brth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: ";abrth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheABRTH(inputValue); #standard validation process found up top
    if (@valTheABRTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];     profB=@player[@playerIndex][8];
      mod = [mod1,mod2].max;
      str_2_number(inputValue.slice(6,1)); target = @numba # @numba <= is the result
      blessDie = (rand 4)+1;
      iRoll1=(rand 20)+1;        iRoll2=(rand 20)+1; 
      iRoll=[iRoll1,iRoll2].max;   result = iRoll + mod + profB + blessDie;
      say = @user.to_s + " rolled a Blessed Advantage attack against Creature " + target.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +   [" + blessDie.to_s + "]  +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The attack Missed!";
          else;
              say = say + "     The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              roll_damage(@weapon[(@player[@playerIndex][1])]); #damage die type in @player
              #@damage & @damage1 now have values
              if iRoll != 20 then;
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1).to_s + " points of damage.";
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "] + " +
                                  mod.to_s + " = " + (mod + @damage1 + @damage2).to_s + " points of damage.";
                   end;
              else
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage3.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1 + @damage3).to_s + " points of damage. CRITICAL HIT!";
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "][" + @damage3.to_s +
                                 "][" + @damage4.to_s + "] + " + mod.to_s + " = " + (mod + @damage1 + @damage2 + @damage3 + @damage4).to_s + " points of damage. CRITICAL HIT!";
                   end;              
              end;
          end;
          
    else;
       say = "Advantage Blessed Roll To Hit needs  ;abrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy DIS-ADVANTAGE BLESSED ATTACK TARGET creature #####################################
bot.message(start_with: ";dbrth") do |event|
    inputValue = event.content;
    check_user_or_nick(event);
    valTheABRTH(inputValue); #standard validation process found up top
    if (@valTheABRTH == true) then;
      get_the_player(); #creates the value in @playerIndex
      mod1 = @player[@playerIndex][3];        mod2 = @player[@playerIndex][2];     profB=@player[@playerIndex][8];
      mod = [mod1,mod2].min;
      str_2_number(inputValue.slice(6,1)); target = @numba # @numba <= is the result
      blessDie = (rand 4)+1;
      iRoll1=(rand 20)+1;        iRoll2=(rand 20)+1; 
      iRoll=[iRoll1,iRoll2].max;   result = iRoll + mod + profB + blessDie;
      say = @user.to_s + " rolled a Blessed Dis-Advantage attack against Creature " + target.to_s + ":\n[" + iRoll1.to_s + "][" + iRoll2.to_s + "] +   [" + blessDie.to_s + "]  +" + mod.to_s + "+" + profB.to_s + " = " + result.to_s;
          if (result < @armour[target]) then;
              say = say + "     The attack Missed!";
          else;
              say = say + "     The attack HIT!";
              #check for iRoll to be 20 for a CRIT
              roll_damage(@weapon[(@player[@playerIndex][1])]); #damage die type in @player
              #@damage & @damage1 now have values
              if iRoll != 20 then;
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1).to_s + " points of damage.";
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "] + " +
                                  mod.to_s + " = " + (mod + @damage1 + @damage2).to_s + " points of damage.";
                   end;
              else
                   if @weapon[(@player[@playerIndex][1])] != "2d6" then;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage3.to_s + "] + " + mod.to_s +
                                  " = " + (mod + @damage1 + @damage3).to_s + " points of damage. CRITICAL HIT!";
                   else;
                      say = say + "\n" + @weapon[(@player[@playerIndex][1])].to_s + " rolled [" + @damage1.to_s + "][" + @damage2.to_s + "][" + @damage3.to_s +
                                 "][" + @damage4.to_s + "] + " + mod.to_s + " = " + (mod + @damage1 + @damage2 + @damage3 + @damage4).to_s + " points of damage. CRITICAL HIT!";
                   end;              
              end;
          end;
          
    else;
       say = "Dis-Advantage Blessed Roll To Hit needs  ;dbrth?    ?= target number (0 to 9)";
    end;    
    event.respond say;
end;

######### easy SPELL ATTACK TARGET creature #####################################
bot.message(start_with: ";srth") do |event|
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
        abs_num_to_name(@player[pIndex][10]);
        profB=@player[pIndex][8]; # Assigns Proficiency Bonus
        iRoll=(rand 20)+1;
        result = iRoll + spellCastMod + profB;
        if (iRoll == 20) then sayHit = "The SPELL attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The SPELL attack against Creature " + target.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled a (" + @ABSname + ") SPELL attack: [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The SPELL attack Missed!";
        else;
            say = say + sayHit; 
        end;
    else;
      say = "Roll To Hit needs  ;srth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;

######### easy ADVANTAGE SPELL ATTACK TARGET creature #####################################
bot.message(start_with: ";asrth") do |event|
    inputValue = event.content;
    target = Integer(inputValue.slice(6,1)) rescue false;
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
        if (iRoll == 20) then sayHit = "The Advantage SPELL attack against Creature " + target.to_s + "  is a CRITICAL HIT!" else; sayHit = "The Advantage SPELL attack against Creature " + target.to_s + "  HIT!" end;
        say = theUser.to_s + " rolled an Advantage SPELL attack: [" + iRoll1.to_s + "][" + iRoll2.to_s + "]    [" + iRoll.to_s + "] +" + spellCastMod.to_s + "+" + profB.to_s + " = " + result.to_s + "\n";
        if (result < @armour[target]) then;
            say = say + "The Advantage SPELL attack Missed!";
        else;
            say = say + sayHit; 
        end;
    else;
      say = "Roll To Hit needs  ;srth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;

######### easy DISADVANTAGE SPELL ATTACK TARGET creature #####################################
bot.message(start_with: ";dsrth") do |event|
    inputValue = event.content;
    target = Integer(inputValue.slice(6,1)) rescue false;
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
      say = "Roll To Hit needs  ;srth?   ?= target number (0 to 9)";
    end;    
        event.respond say;
end;


########## DAMAGE Sneak Attack Dagger d4 ##############
bot.message(start_with: ";SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (dagger) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;


########## DAMAGE Sneak Attack Dagger d4 CRITICAL ##############
bot.message(start_with: ";!SAD4") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (dagger) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "] = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 ##############
bot.message(start_with: ";SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (short sword) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Short Sword d6 CRITICAL ##############
bot.message(start_with: ";!SAD6") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " CRITICAL Sneak Attack (short sword) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "] = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;


########## DAMAGE Sneak Attack Rapier d8 ##############
bot.message(start_with: ";SAD8") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2];
       (0..2).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;
       responseValue = @user.to_s + " Sneak Attack (rapier) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot use this damage type";
    end;
  event.respond responseValue;
end;

########## DAMAGE Sneak Attack Rapier d8 CRITICAL ##############
bot.message(start_with: ";!SAD8") do |event|
    inputValue = event.content;
    check_user_or_nick(event)
    if (@user.slice(0,2) == "Sq") ||  (@user.slice(0,2) == "Qu") || (@user.slice(0,2) == "Al") then
       totalDmg=0;
       dDie = [0,1,2,3,4,5];
       (0..5).each do |x|;
          dDie[x]=(rand 6)+1;
          totalDmg=totalDmg + dDie[x];
       end;

       responseValue = @user.to_s + " CRITICAL Sneak Attack (rapier) damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "][" + dDie[3].to_s + "][" + dDie[4].to_s + "][" + dDie[5].to_s +
                                      "] = " + totalDmg.to_s;
    else;
       responseValue  = "You cannot cause this damage type.";
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
         responseValue = @user.to_s + " Magic Missile damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] +3 = " + lesserDmg.to_s +
                                       "\nUp Cast damage would add [" + dDie[3].to_s + "] +1 = " + totalDmg.to_s;
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
         responseValue = @user.to_s + " Aganazzar's Scorcher damage: [" + dDie[0].to_s + "][" + dDie[1].to_s + "][" + dDie[2].to_s + "] = " + totalDmg.to_s +
                                       "\nTarget makes a DEX save to take half damage";
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

########## DAMAGE Healing Word ##############
bot.message(start_with: ";HWORD") do |event|
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


##################  d4. ##########################
bot.message(contains:"d4.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d4.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d4. requires  ?d4.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d4 " + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 4)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
    end;
    event.respond say;
end;

################## d6. ##########################
bot.message(contains:"d6.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d6.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d6. requires  ?d6.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d6 " + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 6)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
    end;
    event.respond say;
end;

################## d8. ##########################
bot.message(contains:"d8.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d8.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d8. requires  ?d8.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d8 " + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 8)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
    end;
    event.respond say;
end;

################## d10. ##########################
bot.message(contains:"d10.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d10.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d10. requires  ?d10.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d10 " + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 10)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
    end;
    event.respond say;
end;

################## d12. ##########################
bot.message(contains:"d12.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d12.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d12. requires  ?d12.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d12 " ++ " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 12)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
    end;
    event.respond say;
end;

################## d20. ##########################
bot.message(contains:"d20.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d20.");  # uses @tempVar to set value of @howManyDice
    chkNum = Integer(@howManyDice) rescue false;
    if ( chkNum == false ) then;
       say = " d20. requires  d20.  OR   ?d20.? where ? are integers (1 to 9)."
    else
       str_2_number(@howManyDice); #sets the value of @numba
       say = @user.to_s + " rolled " + @numba.to_s + "d20 " + " + " + @whatPlus.to_s + "\n";
       die=[0,0,0,0,0,0,0,0,0]; total=0;
       (0..(@numba-1)).each do |x|;
           die[x]=(rand 20)+1;
           say = say + "[" + die[x].to_s + "]";
           total=total + die[x];
       end;
       total = total + @whatPlus;
       say = say + " + " + @whatPlus.to_s + " = " + total.to_s;
    end;
    event.respond say;
end;

################## d20a. ##########################
bot.message(start_with:"d20a.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d20a.");  # uses @tempVar to set value of @howManyDice
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
    end;
    event.respond say;
end;

################## d20d. ##########################
bot.message(start_with:"d20d.") do |event|
    check_user_or_nick(event);      @tempVar = event.content;     parse_the_d("d20d.");  # uses @tempVar to set value of @howManyDice
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
    end;
    event.respond say;
end;

################## d20d. ##########################
bot.message(contains:"help") do |event|
  lyrics = Array.new
  lyrics[0]="Help me if you can, I'm feeling down";
  lyrics[1]="And I do appreciate you being 'round";
  lyrics[2]="Help me get my feet back on the ground";
  lyrics[3]="Won't you please, please help me?";
  say = lyrics[(rand 4)].to_s + " \n\n";
  say = say + "HELP for   d4.    d6.    d8.    d10.    d12.  and  .d20: \n";
  say = say + "d4.3  rolls 1d4 + 3         d6.-2   rolls 1d6 -2 \n";
  say = say + "2d8.  rolls 2d8 + 0        3d8.-1   rolls 3d8 -1 \n";
  say = say + " \n"
  say = say + "d20a.4 rolls Advantage d20 + 4     d20d.-5  rolls Dis-Advantage d20 -5"
    event.respond say;
end;

def parse_the_d(incoming);
  theIndex1 = @tempVar.index(incoming);
  @howManyDice = @tempVar.slice(0,(theIndex1));
  if ( @howManyDice == "0" || @howManyDice == "" ) then @howManyDice =1; end;
  theIndex2 = @tempVar.index('.');
  tempVarLen = @tempVar.length;
  @whatPlus = @tempVar.slice((theIndex2+1),(tempVarLen-theIndex2))
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
    if event.user.nick != nil
       theUser = event.user.nick
    else
       theUser = event.user.name
    end;
    pIndex = nil;
    (0..(@player.length-1)).each do |y|  #find the @player pIndex within the array using 5 char of @user
        if (@player[y][0].index(theUser.slice(0,5)) == 0) then pIndex = y;  end; #finds player Index Value (integer or nil)
    end;
    say = theUser + ", your current weapon damage die is set to: " + @weapon[(@player[pIndex][1])].to_s + "\n\n";
    say = say +  "To change weapons, assign a new damage die value using: $Wset \n" +
                 "with an Integer, as shown below. Such as $Wset3 \n\n";
    (0..5).each do |x|;
          say = say +  @weapon[x] + " <=> " + x.to_s  + "    ";
    end;                 
    event.respond say;
end;

bot.message(start_with:"$Wset") do |event|
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
    if (pIndex != nil) && (weaponInt != false) && (weaponInt < 6) then; 
           @player[pIndex][1]=weaponInt;
           say = @player[pIndex][0].to_s + " weapon damage has be set to " + @weapon[(@player[pIndex][1])].to_s;
    else
       say = "Please try: $Wset?  where ? is a single number ( 0 to 5 )"; 
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
    if @user == "Allen" then; # as long as the user is Allen, perform the following
            (0..9).each do |x|;
                acVal = @armour[x].to_s;
                say = say + "Creature " + x.to_s + " has Armour Class " + acVal + "\n";
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
    if (  (cNum != false) && (acVal != false) && (@user == "Allen") ) then;
          @armour[cNum]=acVal;
          say = "Armour Class for Creature " + cNum.to_s + " was set to AC: " + acVal.to_s;
    else;
      say = @user.to_s + " , these is something wrong. \n cNum:" + cNum.to_s + " acVal:" + acVal.to_s + " inputStr:" + inputStr.to_s;   
      say = say + "  input length:" + (inputStr.length).to_s;
    end;
    event.respond say;
end;

bot.message(start_with:"$ALL") do |event|
    check_user_or_nick(event);
    theString = event.content;
    acVal = Integer(theString.slice(4,2)) rescue false
    if ( (@user == "Allen") && (acVal != false) ) then;
             (0..9).each do |x|;
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
    if @user == "Allen" then; # as long as the user is Allen, perform the following
            (0..9).each do |x|;
                hpVal = @HP[x][0].to_s;
                say = say + "Creature " + x.to_s + " currently has " + hpVal + " hit points. \n";
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
    if ( (inputStr.length > 1) && (cNum != false) && (hpVal != false) && (@user == "Allen") ) then;
          @HP[cNum][0]=hpVal;  @HP[cNum][1]= hpVal + 0.0;
          say = "Hit Points for Creature " + cNum.to_s + " was set to: " + hpVal.to_s + "  " + (hpVal + 0.0).to_s;
    else;
      say = @user.to_s + "$HPset?? where first ? is Target Integer and second ? is the HP integers."
    end;
    event.respond say;
end;

bot.message(start_with:"$HPless") do |event|
    check_user_or_nick(event);
    inputStr = event.content.slice(7,4);   # creature Number and AC should be in the string
    creatNum = inputStr.slice(0,1); creatHP = inputStr.slice(1,3); 
    cNum = Integer(creatNum) rescue false; #creature Number
    hpVal = Integer(creatHP) rescue false;  #Value of HP
    if ( (inputStr.length > 1) && (cNum != false) && (hpVal != false) && (@user == "Allen") ) then;
          @HP[cNum][0]=@HP[cNum][0]-hpVal;
          say = "Hit Points for Creature " + cNum.to_s + " was reduced by " + hpVal.to_s + " Now has " + @HP[cNum][0].to_s + " hit points.";
    else;
      say = @user.to_s + "$HPset?? where first ? is Target Integer and second ? is the HP integers."
    end;
    event.respond say;
end;

bot.message(start_with:";damage") do |event|
    check_user_or_nick(event);
       inputStr = event.content.slice(7,4);   # creature Number and AC should be in the string
       creatNum = inputStr.slice(0,1); creatHP = inputStr.slice(1,3); 
       cNum = Integer(creatNum) rescue false; #creature Number
       hpVal = Integer(creatHP) rescue false;  #Value of HP
       if ( (inputStr.length > 1) && (cNum != false) && (hpVal != false) && (@user == "Allen") ) then;
            @HP[cNum][0]=@HP[cNum][0]-hpVal;
            say = "Hit Points for Creature " + cNum.to_s + " , reduced by " + hpVal.to_s + " hit points.";
            health_check(@HP[cNum][0], @HP[cNum][1])
            say = say + "\n\n Creature Number " + cNum.to_s + " looks " + @healthStat;
       else;
        say = ";damage?? where first ? is Target Integer and second ? is the HP integer."
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
  end;
end;


bot.run