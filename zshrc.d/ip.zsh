#!/usr/bin/env zsh
getip() {
    export IP4="$(curl --silent ifconfig.me)"
    echo $IP4
}
