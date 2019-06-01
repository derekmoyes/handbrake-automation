# Derek Moyes <derek (dot) moyes (at) gmail
# https://github.com/derekmoyes/handbrake-automation 

### Fill in these variables ################################################## 
# DVDPath, Linux /dev/dvd, Mac /dev/device, VIDEO_TS
dvdpath=/dev/dvd
videotitle=1
videochapters=53 ### Use the actual number of chapters 
discname=OurVacationDisc1
# Encoder Tune: animation, film, grain, (Blank for none)
encodertune=film
storepath=/Users/yourusername/Movies ### No trailing slash

### Dont change stuff below here #############################################
ripcounter=1
rippath=$storepath/zAutoRipping-$discname

### Start the work ###########################################################
mkdir -p $rippath

### Rip the chapter files 
while [ $ripcounter -le $videochapters ];
do
  ripname=$rippath/$discname-t$videotitle-ch$ripcounter.mp4
  echo Ripping Title $videotitle Chapter $ripcounter to $ripname
  HandBrakeCLI --preset-import-gui -Z "General/HQ 1080p30 Surround" --encoder-tune $encodertune --input $dvdpath --output $ripname --title $videotitle -c $ripcounter --all-audio
  ((ripcounter++))
done
sleep 5

### Clean up #################################################################
zdonePath=$storepath/RipDone
mkdir -p $zdonePath
mv $rippath $zdonePath/$discname
echo Completed $discname, stored at $zdonePath.
