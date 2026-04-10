#!/bin/bash

echo 'alias lutris="/opt/lutris/bin/lutris"' >> ~/.bashrc


# Use this template once you have installed a game with Lutris to start it with an alias,
# change GAME_NAME with a name you decide while GAME_INSIDE_LUTRIS has to be the exact
# name you assigned during game installation with lutris 

# echo 'alias GAME_NAME="/opt/lutris/bin/lutris lutris:rungame/GAME_INSIDE_LUTRIS"' >> ~/.bashrc


#Use this template once you have installed a game manually with wine to start it with an alias.

# echo 'alias GAME_NAME="WINEARCH=YOUR_ARCH  WINEPREFIX=/ABSOLUTE/PATH/TO/PREFIX_FOLDER  wine  /PATH/TO/GAME/EXECUTABLE"'








exec /bin/bash
