#!/bin/sh
# at the moment this is called: find . -iname '*.mkv' | sort | xargs -I"{}" ./convertAppleTv2.sh {}

# @todo check if the script is already running (for cron)

# @todo find . -iname '*.mkv' | sort

	# figure out path and filename
dirname=$(dirname $1)
filename=$(basename $1 .mkv)

# @todo check if output file already exists

# @todo parse ffmpeg -i to look for translations and configure language handling

	# video parameter
	#   -Z preset (use "AppleTV 2" for 720, "High Profile" for 1080 and "iPhone 4" for ... you know)
	#   -2 two-pass encoding ... like 1.6 - 1.8 times slower but better results with smaller files
	#
	# audio parameter (if only one track is present, use without ",")
	#   -a 2,1 (change audio tracks - make second (eng) default e.g.)
	#   -A eng,de (name of audio tracks)
	#   -E faac (codec ... faac by default, only use if video got two tracks but you just want one of them!)
	#   -6 stereo,stereo (mixdown)
	#   -D 2.0,2.0 (dynamic range compression - you want that to watch on the phone!)
	# examples:
	# audio is de / en, want english to be default and stereo mixdown both
	# -a 2,1 -A eng,de -6 stereo,stereo
	# audio is de / en, want english only and stereo mixdown
	# -a 2 -A eng -E faac -6 stereo
	# audio is de / en, want good sound on iPhone
	# -6 stereo,stereo -D 2.0,2.0
HandBrakeCLI -i "${dirname}/${filename}.mkv" -o $filename.mp4 -Z "AppleTV 2"
