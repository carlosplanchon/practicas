#!/bin/bash
# -*- coding: utf-8 -*-

OLD=$(dpkg -l|grep "^rc"|awk '{print $2}')
A="\033[1;33m"
R="\033[0;31m"
F="\033[0m"

function chauoldkernel
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
	echo $A"Limpiando la cache apt..."$F
	apt-get -y clean

	echo $A"Eliminando paquetes huerfanos..."$F
	apt-get -y autoremove

	echo $A"Removiendo viejos archivos de configuración..."$F
	apt-get purge $OLD

	echo $A"Removiendo viejos kernels..."$F
	chauoldkernel

	echo $A"Limpiando imágenes en miniatura..."$F
	rm -rf /home/*/.thumbnails/large/*
	rm -rf /home/*/.thumbnails/normal/*

	echo $A"Limpiando caché de Firefox..."$F
	rm -rf /home/*/.cache/mozilla/firefox/*

	echo $A"Limpiando caché de Google Chrome..."$F
	rm -rf /home/*/.cache/google-chrome/*
}

if [ $USER != root ]; then
  echo $R"Error: tenes que ser root"
  echo $A"Saliendo..."$F
  notify-send "Xubucleaner" "Tenés que ejecutar este programa como root"
  exit 0
fi
clear
notify-send "Xubucleaner" "Iniciando limpieza..."

echo $A"Limpiando las papeleras..."$F
rm -rf /home/*/.local/share/Trash/*/**
rm -rf /root/.local/share/Trash/*/**

limpiar

echo $A"Obteniendo información de los repositorios..."$FINAL
apt-get -y update

echo $A"Actualizándo programas..."$FINAL
apt-get -y upgrade

echo $A"Actualizándo kernel..."$FINAL
apt-get -y dist-upgrade

limpiar

echo $A"Script finalizado - edición por: Carlos Planchón!"$FINAL
notify-send "Xubucleaner" "Listo!"
