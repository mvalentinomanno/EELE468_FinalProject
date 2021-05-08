#!/bin/bash

R_GAIN=/sys/class/misc/chorus/right_gain
L_GAIN=/sys/class/misc/chorus/left_gain


echo .8 > $R_GAIN
echo .8 > $L_GAIN

