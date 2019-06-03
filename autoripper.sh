# Derek Moyes <derek (dot) moyes (at) gmail
# https://github.com/derekmoyes/handbrake-automation 

### Fill in these variables, before each rip ################################# 

## RipType: 
## title  : rips a single file for each title on the disc
## chapter: rips a single file for each chapter of a single title
riptype=title     ## Uncomment only one of these
#riptype=chapter  ## Uncomment only one of these
#videotitle=1     ## Set this for chapter ripping
#videochapters=53 ## Set this for chapter ripping

## DVDPath: Linux /dev/dvd, Mac /dev/yourdevice, VIDEO_TS
dvdpath=/dev/dvd
discname=OurVacationDisc1

## Encoder Tune: animation, film, grain
hbencodertune=film
hbpreset="General/HQ 1080p30 Surround"

## Storage Location: No trailing slash
storepath=/Users/yourusername/Movies

### Do not change stuff below here ###########################################

## Setup

# Detect OS, checking requirements
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=Linux
        echo "Linux machine type found, using GNU grep."
        grepbin=grep
    ;;
    Darwin*)    
        machine=Mac
        echo "Mac machine type found, checking for GNU grep..." 
        if [ -f $(which ggrep) ]
        then
            echo "GNU grep (ggrep) found, continuing."
            grepbin=$(which ggrep)
        else 
            echo "GNU grep (ggrep) not found, you'll need to have brew installed, from:"
            echo "  https://brew.sh/"
            echo ""
            echo "Once you have brew, please install the GNU version of ggrep using:"
            echo "$ brew install grep"
            exit 1
        fi
    ;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Create storage location
rippath=$storepath/zAutoRipping-$discname
echo "Creating $rippath..."
mkdir -p $rippath

### Start the work ###########################################################

case "${riptype}" in
    title*) 
        echo "Beginning title rips..."
        # Read handbrake's stderr into variable
        rawout=$(HandBrakeCLI -i $dvdpath -t 0 2>&1 >/dev/null)
        # Parse the variable to get the count
        count=$(echo $rawout | $grepbin -Pao " title \d{1,2}+:" | wc -l)

        for title in $(seq $count)
        do
            ripname=$rippath/$discname-t$title.mp4
            echo Ripping $discname Title $title to $ripname
            HandBrakeCLI --preset-import-gui --preset "$hbpreset" --encoder-tune $hbencodertune --input $dvdpath --output $ripname --title $title --all-audio
        done 
    ;; 
    chapter*)
        echo "Beginning chapter rips..."
        ripcounter=1
        while [ $ripcounter -le $videochapters ];
        do
            ripname=$rippath/$discname-t$videotitle-ch$ripcounter.mp4
            echo Ripping Title $videotitle Chapter $ripcounter to $ripname
            HandBrakeCLI --preset-import-gui --preset "$hbpreset" --encoder-tune $hbencodertune --input $dvdpath --output $ripname --title $videotitle -c $ripcounter --all-audio
            ((ripcounter++))
        done
    ;;
esac

sleep 5

### Clean up #################################################################
zdonePath=$storepath/RipDone
mkdir -p $zdonePath
mv $rippath $zdonePath/$discname
echo Completed $discname, stored at $zdonePath.
case "${machine}" in
    Mac*)    say Disc $discname rip complete;;
esac
