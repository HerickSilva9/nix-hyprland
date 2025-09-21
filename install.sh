#!/bin/bash


mkdir -p "$HOME/.wallpapers"
pushd "$HOME/.wallpapers"
git clone https://github.com/dracula/wallpaper.git
mv wallpaper/ DraculaWallpapers/
popd