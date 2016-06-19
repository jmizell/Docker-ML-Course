#!/bin/bash

export DISPLAY=:100.0
Xvfb :100 -ac -screen 0 ${VNC_RESOLUTION}x24+32 &
sleep 5s
fluxbox &
x11vnc -display :100.0 -forever -shared 