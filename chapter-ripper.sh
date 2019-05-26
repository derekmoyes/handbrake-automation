# Derek Moyes <derek (dot) moyes (at) gmail
# https://github.com/derekmoyes/handbrake-automation 
### Fill in these variables ################################################## 
videotitle=2
videochapters=53 ### Use the actual number of chapters 
discname=OurVacationDisc1
storepath=/Users/yourusername/Movies ### No trailing slash

### Dont change stuff below here #############################################
ripcounter=1
rippath=$storepath/zAutoRipping-$discname-t$videotitle

### Start the work ###########################################################
mkdir -p $rippath

### Rip the chapter files 
while [ $ripcounter -le $videochapters ];
do
  ripname=$rippath/$discname-t$videotitle-ch$ripcounter.mp4
  echo Ripping Title $videotitle Chapter $ripcounter to $ripname
  HandBrakeCLI --preset-import-gui -Z "Legacy/High Profile" -i VIDEO_TS -o $ripname -t $videotitle -c $ripcounter --all-audio
  ((ripcounter++))
done
sleep 5

### Clean up #################################################################
zdonePath=$storepath/RipDone-$discname-t$videotitle
mv $rippath $zdonePath
echo Completed $discname
