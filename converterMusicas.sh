#!/bin/bash

for arquivos in "$@"
do
	ffmpeg -i "${arquivos}" "${arquivos%.*}".mp3 -loglevel quiet
	echo ${arquivos%.*}.mp3 Convertido!
done
