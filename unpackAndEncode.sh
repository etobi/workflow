#!/bin/sh

PASSWORD=$1
DOWNLOADS=/home/Workflow/FinishedDownloads
UNPACKED=/home/Workflow/Unpacked
READY=/home/Workflow/Ready
JABBER=foobar@jabber

cd $DOWNLOADS
ls -l | sendxmpp $JABBER

cd $UNPACKED
find $DOWNLOADS -name *.part1.rar -exec unrar e -p$PASSWORD {} \; -print

for AviFile in `ls $UNPACKED/*.avi | sort`; do
	echo $AviFile;
	base=`basename $AviFile .avi`	
	echo "Codiere " $base | sendxmpp $JABBER
	HandBrakeCLI -i $AviFile -o $READY/$base.mp4 -Z "AppleTV 2" \;
	rm -f $AviFile
done

echo "Alles fertig" | sendxmpp $JABBER
cd $READY
ls -l | sendxmpp $JABBER

