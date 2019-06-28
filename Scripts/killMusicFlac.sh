#!/bin/bash

# A ideia é obter o pid da música e usar o comando kill 
kill `ps a -o pid,command | grep /usr/bin/play | tr '\n' ' ' | sed "s/^\(\<[[:digit:]]*\>\) .*$/\1/"`
