# Clean up drive before unmount
cleandrive() {
  if [ -n "$1" ] && [ -d "/Volumes/$1/" ]; then
    read -r -p "Clean /Volumes/$1/ and unmount? [y/N] " response
      if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        find "/Volumes/$1/" -name "._*" -type f -delete
        find "/Volumes/$1/" -name "*.DS_Store" -type f -ls -delete
        rm -rf "/Volumes/$1/.Spotlight-V100/"
        rm -rf "/Volumes/$1/.Trashes/"
        diskutil unmount "/Volumes/$1/"
        echo "Done..."
      fi
  else
    echo "Drive '$1' missing"
  fi
}

cleandrive