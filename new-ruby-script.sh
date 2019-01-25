#!/bin/bash

#create a new ruby shell script with Scriptster and docopt support 
new-ruby-script()
{
    if [ -n "$1" ]; then
        local script="$1"
    else
        local script=`mktemp scriptster.rb.XXXX`
    fi

    local url="https://raw.githubusercontent.com/pazdera/scriptster/master"
    curl "$url/examples/minimal-template.rb" >"$script"

    chmod +x "$script"
    $EDITOR "$script"
}

new-ruby-script