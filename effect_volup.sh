#!/bin/bash


R_VOL=/sys/class/misc/chorus/right_volume
L_VOL=/sys/class/misc/chorus/left_volume


echo 1 > $L_VOL
echo 1 > $R_VOL 
