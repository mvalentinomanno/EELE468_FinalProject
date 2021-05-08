#!/bin/bash

R_GAIN=/sys/class/misc/chorus/right_gain
L_GAIN=/sys/class/misc/chorus/left_gain


echo .4 > $R_GAIN
echo .4 > $L_GAIN

