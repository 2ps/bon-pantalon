#!/bin/bash
if [ -d /u/dotfiles ] ; then
    echo "copying dircolors"
    cp /u/dotfiles/zsh/.dircolors "${1}/dircolors"
else
    echo "creating empty dircolors"
    echo "" > "${1}/dircolors"
fi
