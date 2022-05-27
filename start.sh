mkdir frames_org
rm blockanimframes/*
rm frames_block/*
rm frames_org/*
ffmpeg -i 2955fb5871aad45d92b815f3ff0856b6.gif -vf fps=25 frames_org/$filename%03d.png
mogrify -distort DePolar 0 frames_org/*.png
ffmpeg -framerate 25 -pattern_type glob -i 'frames_org/*.png' -vf scale=256:128 -c:v r210 output.avi
#ffmpeg -framerate 25 -pattern_type glob -i 'frames_org/*.png' -c:v r210 output.avi
