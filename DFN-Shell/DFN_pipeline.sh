#!/bin/bash

helpFunction()
{
	echo "Usage: $0 -i Input -o Output"
	echo -e "\t -i: Stream URL/\"Mic\"/File"
	echo -e "\t\t To play a file: use FILE:///PATH_TO_FILE/FILENAME"
	echo -e "\t\t To use microphone, use \"mic\""
	
	echo -e "\t -o: \"Device\"/File"
	echo -e "\t\t To write into the file, use relative/ absolute path."
	echo -e "\t\t To play on sound device, use \"device\"."
	
	exit 0
}

while getopts "i:o:?" opt
do
   case "$opt" in
      i ) input="$OPTARG" ;;
      o ) output="$OPTARG" ;;
      # l ) listDevice="$OPTARG" ;;
      ? ) helpFunction ;;
   esac
done



src="$(tr [A-Z] [a-z] <<< "$input")"

sink="$(tr [A-Z] [a-z] <<< "$output")"

gst_command="gst-launch-1.0 -e "

if [ -z $input ] || [ -z output ]; then
	helpFunction
fi

if [[ $src == "mic" ]]; then
	if [[ $sink == "device" ]]; then
		gst_command+="pulsesrc ! audioconvert ! audioresample ! DFN ! pulsesink"
	else
		gst_command+="pulsesrc ! audioconvert ! audioresample ! DFN ! wavenc ! filesink location=$output"
	fi
else
	gst_command+="uridecodebin uri=$input name=demux  "
	if [[ $sink == "device" ]]; then
		gst_command+="demux. ! videoconvert ! videoscale ! autovideosink  demux. ! audioconvert ! audioresample ! DFN ! autoaudiosink"
	else
		gst_command+="demux. ! videoconvert ! videoscale ! x264enc ! mp4mux name=mux ! filesink location=$output  demux. ! audioconvert ! audioresample ! DFN ! voaacenc ! mux."
	fi
fi

echo $gst_command

eval $gst_command
