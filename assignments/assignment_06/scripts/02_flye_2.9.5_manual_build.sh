#!/bin/bash

LOC=${HOME}/programs
#have to specify ${LOC}/Flye b/c if jsut ${LOC} it'll try to write everthing into the programs directory without creating a Flye sub-directory (or at least according to ChatGPT, and that sounds real annoying to deal with)
git clone https://github.com/fenderglass/Flye ${LOC}/Flye
cd ${LOC}/Flye
make
echo "export PATH=\$PATH:${LOC}/Flye/bin" >> ~/.bashrc
