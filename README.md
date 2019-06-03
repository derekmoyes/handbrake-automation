# handbrake-automation
* Requires HandBrakeCLI, available here: https://handbrake.fr/downloads.php 
* Tested with HandBrakeCLI 1.0.2
* If running on a Mac, also requires GNU Grep (ggrep) from https://brew.sh/

## autoripper.sh
This will rip VOB titles or DVDs in either title or chapter mode, as if you were using the HandBrake GUI, only the setup is faster.

Edit the file and fill in the variables that are pertinent to you.

Title ripping is exceptionally easy if there are a bunch of similar titles, as you don't have to use the GUI to select and configure each one.

Chapter ripping will rip a single VOB title into individual chapter files, which is very convenient for splitting one large movie into several smaller ones.

## OLD: chapter-ripper.sh
Chapter ripper has been superseded by autoripper.
This will rip a VOB title into individual chapter files. Very convenient for converting home movie DVDs created as one large movie, from many smaller ones.

## OLD: title-ripper.sh
Title ripper has been superseded by autoripper.
This will rip VOB titles or DVDs as if you were using the handbrake GUI, except faster, if all the tracks are similar, you don't have to GUI select them all.
