#!/bin/bash
mkdir $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
curl -fLo Hurmit.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip
unzip Hurmit.zip
rm -f Hurmit.zip
rm -f README.md
rm -f LICENSE
