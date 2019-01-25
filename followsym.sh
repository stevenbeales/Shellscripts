#!/bin/bash
#follow sym links to find ultimate file pointed to 

followsym() {
	if [[ -e $1 || -h $1 ]]; then
		file=$1
	else
		file=`which $1`
	fi
	if
		if [[ -e $file || -L $file ]]; then
			if [[ -L $file ]]; then
				echo `ls -ld $file | perl -ane 'print $F[7]'` '->'
				folsym `perl -le '$file = $ARGV[0];
				$dest = readlink $file;
				if ($dest !~ m{^/}) {
					$file =~ s{(/?)[^/]*$}{$1$dest};
				} else {
				$file = $dest;
			}
			$file =~ s{/{2,}}{/}g;
			while ($file =~ s{[^/]+/\.\./}{}) {
				;
			}
			$file =~ s{^(/\.\.)+}{};
			print $file' $file`
		else
			ls -d $file
		fi
	else
		echo $file
	fi
}