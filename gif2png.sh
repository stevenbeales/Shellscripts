
gif2png() {
	if [[ $# = 0 ]]
	then
		echo "Usage: $0 foo.gif"
		echo "Purpose: change a GIF file to a PNG file"
	else
		output=`basename $1 .gif`.png
		convert  $1 $output
		touch -r $1 $output
		ls -l $1 $output
	fi
}

gif2png