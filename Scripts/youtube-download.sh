#!/bin/bash
#Script que utiliza os pacotes youtube-dl e ffmpeg para baixar audio do YouTube e converter esse arquivo para o formato FLAC
#Apenas variáveis do sistema são escritas com letras maiúsculas, variáveis locais com letras minúsculas
#AVISO: Fazer com que o script tenha um popup para inserir o link e colocá-lo em ~/.local/bin/ - CONCLUÍDO
#AVISO: Retirar as mensagens que notificam - CONCLUÍDO (retirar todos os 'echo' e 'clear')

erro_abortar(){
   notify-send --expire-time=3250 "YouTube-Flac" "Áudio: $nome_final - Falhou..."
}
trap erro_abortar EXIT
set -e

#clear
cd ~/Música/
#Quero que toda a operação aconteça na pasta: ~/Música/

#-----Teste com Zenity (popup para inserir o link)---SUCESSO!---
link="$@"

#Obtendo e guardando a string na variável: link---REMOVIDO---

#O caracter ($) serve para pegar o conteúdo da variável
#Sempre colocar entre quotes (variáveis) e entre single quotes (quando se quer realizar comandos)
#----COLOCAR CONDIÇÃO PARA CASO NÃO TENHA A PASTA, CRIAR UMA NOVA PASTA----
pastaAudio="AudiosYouTube/"

#Obtendo o nome do arquivo e modificando (retirando o .formato), para evitar conflito
arquivo=`youtube-dl --get-filename $link`;

#(#)PREFIXO; (%)SUFIXO; comandos que indicam o sentido da operação, o caracter será o último a ser removido; seguindo o sentido da operação, colocar (*) para remover o resto do texto
arquivo="${arquivo%.*}";
#Armazena somente a parte do link que será removido do nome do arquivo convertido em flac
tagyoutube="${link#*=}";
nome_final="${arquivo%"-$tagyoutube"}";

#Comando principal: fará o download e a conversão para o formato .flac
#Comandos foram otimizados: && (próximo comando só será executado se o anterior tiver sucesso); || (próximo comando será executado com falha do primeiro); ";" (Comando será executado).
youtube-dl -q -f bestaudio "$link";
#${colocar entre chaves garante que a variável não será modificada}

#Converte modificando o nome do arquivo corretamente
ffmpeg -i "$arquivo"* "$nome_final.flac" -loglevel quiet;

#Mover o arquivo para a pasta AudiosYouTube, verificando se a pasta existe
if [ -d "$pastaAudio" ]
then
   mv "$nome_final".flac "$pastaAudio";
fi;

#Verifica se o arquivo existe e remove o arquivo original
if [ -e "$arquivo"* ]
   then
   rm "$arquivo"*
fi;

#Verifica se se algum comando acima deu errado e retorna notificação 
sucesso(){
   notify-send --expire-time=3250 "YouTube-Flac" "Áudio: $nome_final - Concluído com Sucesso!"
}
trap sucesso EXIT

