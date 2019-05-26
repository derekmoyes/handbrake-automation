# Derek Moyes <derek (dot) moyes (at) gmail
# https://github.com/derekmoyes/handbrake-automation 
# Original version:
#   https://superuser.com/questions/394516/how-to-convert-50-episodes-from-dvd-into-50-mp4-with-handbrake-easily

### Fill in these variables ################################################## 
# DVDPath, Linux /dev/dvd, Mac /dev/device
dvdpath=/dev/dvd
discname=OurVacationDisc1
storepath=/Users/yourusername/Movies # no trailing slash

### Dont change stuff below here #############################################
rippath=$storepath/zAutoRipping-$discname

### Start the work ###########################################################
# Read handbrake's stderr into variable
rawout=$(HandBrakeCLI -i $dvdpath -t 0 2>&1 >/dev/null)
# Parse the variable to get the count
count=$(echo $rawout | grep -Eao "\\+ title [0-9]+:" | wc -l)

mkdir -p $rippath

for title in $(seq $count)
do
    ripname=$rippath/$discname-t$title.mp4
    echo Ripping $discname Title $title to $ripname
    HandBrakeCLI --preset-import-gui -Z "General/HQ 1080p30 Surround" --encoder-tune animation --input $dvdpath --title $title --output $ripname
done

### Clean up #################################################################
zdonePath=$storepath/RipDone-$discname
mv $rippath $zdonePath
echo Completed $discname
