#!/bin/bash


R_VOL=/sys/class/misc/chorus/right_volume
L_VOL=/sys/class/misc/chorus/left_volume


echo .33 > $L_VOL
echo .33 > $R_VOL
