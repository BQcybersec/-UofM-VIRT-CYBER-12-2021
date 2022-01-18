#!/bin/bash
cd /03-student/
mkdir Homework3
cd Homework3
mkdir Lucky_Duck_Investigation
cd Lucky_Duck_Investigation

mkdir Roulette_Loss_Investigation
cd Roulette_Loss_Investigation

mkdir Player_Analysis Dealer_Analysis Player_Dealer_Correlation
touch Notes_Player_Analysis Notes_Dealer_Analysis Notes_Player_Dealer_Correlation
mv Notes_Player_Analysis Player_Analysis
mv Notes_Dealer_Analysis Dealer_Analysis
mv Notes_Player_Dealer_Correlation Player_Dealer_Correlation

cd ../../

wget "https://tinyurl.com/3-HW-setup-evidence" && chmod +x ./3-HW-setup-evidence && ./3-HW-setup-evidence

cd Dealer_Schedules_0310
cp 0310_Dealer_schedule 0312_Dealer_schedule 0315_Dealer_schedule ../Lucky_Duck_Investigation/Roulette_Loss_Investigation/Dealer_Analysis

cd ../Roulette_Player_WinLoss_0310
cp 0310_win_loss_player_data 0312_win_loss_player_data 0315_win_loss_player_data ../Lucky_Duck_Investigation/Roulette_Loss_Investigation/Player_Analysis

cd ../Lucky_Duck_Investigation/Roulette_Loss_Investigation/Player_Analysis/
grep - 0310_win_loss_player_data 0312_win_loss_player_data 0315_win_loss_player_data > Roulette_Losses
