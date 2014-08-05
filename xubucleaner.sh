#!/bin/bash
# -*- coding: utf-8 -*-

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
YELLOW="\033[1;33m"
RED="\033[0;31m"
ENDCOLOR="\033[0m"

function borrar_oldkernel
{
	ls /boot/ | grep vmlinuz | sed 's@vmlinuz-@linux-image-@g' | sed '$d' | sed '$d' > /tmp/kernelList
	if [ -s /tmp/kernelList ]; then
		echo "Se eliminarán los siguientes kernels\n`cat /tmp/kernelList`"
		for I in `cat /tmp/kernelList`; do
			apt-get remove $I
			echo "Eliminando $I..."
		done
		rm -f /tmp/kernelList
		echo "Actualizando gestor de arranque..."
		update-grub
		update-burg
	fi
}

function limpiar
{
	echo -e $YELLOW"Limpiando la cache apt..."$ENDCOLOR
	apt-get clean

	echo -e $YELLOW"Eliminando paquetes huerfanos..."$ENDCOLOR
	apt-get autoremove

	echo -e $YELLOW"Removiendo viejos archivos de configuración..."$ENDCOLOR
	apt-get purge $OLDCONF

	echo -e $YELLOW"Removiendo viejos kernels..."$ENDCOLOR
	borrar_oldkernel

	echo -e $YELLOW"Limpiando imágenes en miniatura..."$ENDCOLOR
	rm -rf /home/*/.thumbnails/large/*
	rm -rf /home/*/.thumbnails/normal/*

	echo -e $YELLOW"Limpiando caché de Firefox..."$ENDCOLOR
	rm -rf /home/*/.cache/mozilla/firefox/*
}

if [ $USER != root ]; then
  echo -e $RED"Error: tenes que ser root"
  echo -e $YELLOW"Saliendo..."$ENDCOLOR
  notify-send "Xubucleaner" "Tenés que ejecutar este programa como root"
  exit 0
fi
clear
notify-send "Xubucleaner" "Iniciando limpieza..."

echo -e $YELLOW"Limpiando las papeleras..."$ENDCOLOR
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

limpiar

echo -e $YELLOW"Obteniendo información de los repositorios..."$ENDCOLOR
apt-get update

echo -e $YELLOW"Actualizándo programas..."$ENDCOLOR
apt-get upgrade

echo -e $YELLOW"Actualizándo kernel..."$ENDCOLOR
apt-get dist-upgrade

limpiar

echo -e $YELLOW"Script finalizado - edición por: Carlos Planchón!"$ENDCOLOR
notify-send "Xubucleaner" "Listo!"
