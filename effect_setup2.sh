#!/bin/bash
R_EN=/sys/class/misc/chorus/right_enable
L_EN=/sys/class/misc/chorus/left_enable

R_PHASE1=/sys/class/misc/chorus/right_delay
L_PHASE1=/sys/class/misc/chorus/left_delay

R_PHASE2=/sys/class/misc/chorus/right_delay2
L_PHASE2=/sys/class/misc/chorus/left_delay2

R_GAIN=/sys/class/misc/chorus/right_gain
L_GAIN=/sys/class/misc/chorus/left_gain

R_VOL=/sys/class/misc/chorus/right_volume
L_VOL=/sys/class/misc/chorus/left_volume




echo 1 > $R_EN
echo 1 > $L_EN
echo 20 > $R_PHASE1
echo 20 > $L_PHASE1
echo 8 > $R_PHASE2
echo 8 > $L_PHASE2
echo .8 > $R_GAIN
echo .8 > $L_GAIN
echo 1 > $L_VOL
echo 1 > $R_VOL
