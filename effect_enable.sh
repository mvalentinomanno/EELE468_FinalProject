#!/bin/bash
R_EN=/sys/class/misc/chorus/right_enable
L_EN=/sys/class/misc/chorus/left_enable

echo 1 > $R_EN
echo 1 > $L_EN
