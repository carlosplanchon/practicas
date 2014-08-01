#!/bin/bash
# -*- coding: utf-8 -*-

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
YELLOW="\033[1;33m"
RED="\033[0;31m"
ENDCOLOR="\033[0m"

if [ $USER != root ]; then
  echo -e $RED"Error: tenes que ser root"
  echo -e $YELLOW"Saliendo..."$ENDCOLOR
  exit 0
fi

echo -e $YELLOW"Limpiando la cache apt..."$ENDCOLOR
sudo apt-get clean

echo -e $YELLOW"Removiendo viejos archivos de configuración..."$ENDCOLOR
sudo apt-get purge $OLDCONF

echo -e $YELLOW"Removiendo viejos kernels..."$ENDCOLOR
sudo apt-get $OLDKERNELS

echo -e $YELLOW"Limpiando las papeleras..."$ENDCOLOR
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e $YELLOW"Obteniendo información de los repositorios..."$ENDCOLOR
sudo apt-get update

echo -e $YELLOW"Actualizándo programas..."$ENDCOLOR
sudo apt-get upgrade

echo -e $YELLOW"Actualizándo kernel..."$ENDCOLOR
sudo apt-get dist-upgrade

echo -e $YELLOW"Limpiando la cache apt..."$ENDCOLOR
sudo apt-get clean

echo -e $YELLOW"Removiendo viejos archivos de configuración..."$ENDCOLOR
sudo apt-get purge $OLDCONF

echo -e $YELLOW"Removiendo viejos kernels..."$ENDCOLOR
sudo apt-get $OLDKERNELS

echo -e $YELLOW"Limpiando imágenes en miniatura..."$ENDCOLOR
rm -rf /home/*/.thumbnails/large/*
rm -rf /home/*/.thumbnails/normal/*

echo -e $YELLOW"Limpiando caché de Firefox..."$ENDCOLOR
rm -rf /home/*/.cache/mozilla/firefox/*

echo -e $YELLOW"Script finalizado - edición por: Carlos Planchón!"$ENDCOLOR
