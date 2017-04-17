#!/bin/sh -e

# Take a screenshot
scrot /tmp/lockscreen.png

# Pixellate it 10x
convert /tmp/lockscreen.png -scale 10% -scale 1000% /tmp/lockscreen.png
#convert /tmp/lockscreen.png -blur 0x7 /tmp/lockscreen.png

# Lock screen displaying this image.
i3lock -i /tmp/lockscreen.png

# Remove the image... just in case.
rm /tmp/lockscreen.png

# Turn the screen off after a delay.
#sleep 60; pgrep i3lock && xset dpms force off
