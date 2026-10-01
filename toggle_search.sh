#!/bin/bash
if pgrep -f "quickshell -p /home/hamlak/search.qml" > /dev/null; then
    killall quickshell
else
    quickshell -p /home/hamlak/search.qml &
fi

