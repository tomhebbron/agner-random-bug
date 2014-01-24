#!/bin/bash

#Fetch files to /tmp

mkdir tmp

cd tmp

curl -O "http://www.agner.org/random/randomc.zip"
curl -O "http://www.agner.org/optimize/asmlib.zip"

unzip -o randomc.zip
unzip -o asmlib.zip
unzip -o asmlibSrc.zip



