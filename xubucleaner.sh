#!/bin/bash
# -*- coding: utf-8 -*-

OLD=$(dpkg -l|grep "^rc"|awk '{print $2}')
A="\033[1;33m"
R="\033[0;31m"
FINAL="\033[0m"

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
	echo -e $A"Limpiando la cache apt..."$FINAL
	apt-get -y clean

	echo -e $A"Eliminando paquetes huerfanos..."$FINAL
	apt-get -y autoremove

	echo -e $A"Removiendo viejos archivos de configuración..."$FINAL
	apt-get purge $OLD

	echo -e $A"Removiendo viejos kernels..."$FINAL
	borrar_oldkernel

	echo -e $A"Limpiando imágenes en miniatura..."$FINAL
	rm -rf /home/*/.thumbnails/large/*
	rm -rf /home/*/.thumbnails/normal/*

	echo -e $A"Limpiando caché de Firefox..."$FINAL
	rm -rf /home/*/.cache/mozilla/firefox/*

	echo -e $A"Limpiando caché de Google Chrome..."$FINAL
	rm -rf /home/*/.cache/google-chrome/*
}

if [ $USER != root ]; then
  echo -e $R"Error: tenes que ser root"
  echo -e $A"Saliendo..."$FINAL
  notify-send "Xubucleaner" "Tenés que ejecutar este programa como root"
  exit 0
fi
clear
notify-send "Xubucleaner" "Iniciando limpieza..."

echo -e $A"Limpiando las papeleras..."$FINAL
rm -rf /home/*/.local/share/Trash/*/**
rm -rf /root/.local/share/Trash/*/**

limpiar

echo -e $A"Obteniendo información de los repositorios..."$FINAL
apt-get -y update

echo -e $A"Actualizándo programas..."$FINAL
apt-get -y --force-yes upgrade

echo -e $A"Actualizándo kernel..."$FINAL
apt-get -y --force-yes dist-upgrade

limpiar

echo -e $A"Script finalizado - edición por: Carlos Planchón!"$FINAL
notify-send "Xubucleaner" "Listo!"
