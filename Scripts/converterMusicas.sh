#!/bin/bash

for arquivos in "$@"
do
	echo $arquivos
	ffmpeg -i "${arquivos}" "${arquivos%.*}".mp3 -loglevel quiet
	echo Convertido!
done
