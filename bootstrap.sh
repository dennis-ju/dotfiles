#!/bin/sh

mkdir -p ~/.config
for dir in ~/dotfiles/.config/*
do
    echo $dir
    ln -s $dir ~/.config/
done
