
count=0
vidposX=0
vidposY=0
cropsize=16
#mkdir frames_block
#mkdir blockanimframes
#rm blockanimframes/*
parseanimframe () {
	cropposX=$((cropsize*vidposX))
	cropposY=$((cropsize*vidposY))
	ffmpeg -i output.avi -filter:v crop=$cropsize:$cropsize:$cropposX:$cropposY -c:v r210 blockframe.avi
	ffmpeg -i blockframe.avi -vf fps=25 frames_block/%04d.png
	rm blockframe.avi
	montage frames_block/*.png -geometry +0+0 -tile x1 blockanimframes/$(echo $count | sed -e :a -e 's/^.\{1,3\}$/0&/;ta'
).png
}
echo '#' > animations.txt
vidposY=0
for i in {1..8}
do
	for i in {1..16}
	do
		count=$((count + 1))
		parseanimframe
		animputputY=$((16*vidposY))
		animputputX=$((vidposX))
		animputput_realY=$((animputputY+animputputX))
		#<TileX> <TileY> <FrameX> <FrameY> <Frame size> <Frames count> <Tick delay>
		echo $vidposX $((8+vidposY)) 0 $((cropsize*animputput_realY)) $cropsize 58 0 >> animations.txt
		vidposX=$((vidposX + 1))
	done
	vidposX=0
	vidposY=$((vidposY + 1))
done

montage blockanimframes/*.png -geometry +0+0 -tile 1x  animations.png

