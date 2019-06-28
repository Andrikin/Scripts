#!/bin/sh

#Comando que irá habilitar aliases no Rofi
alias|awk -F'[ =]' '{print $2}'
