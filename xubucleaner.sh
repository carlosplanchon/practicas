#!/bin/bash
# -*- coding: utf-8 -*-

OLD=$(dpkg -l|grep "^rc"|awk '{print $2}')
A="\033[1;33m"
R="\033[0;31m"
R="\033[0m"

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
	echo -e $A"Limpiando la cache apt..."$R
	apt-get -y clean

	echo -e $A"Eliminando paquetes huerfanos..."$R
	apt-get -y autoremove

	echo -e $A"Eliminando paquetes viejos..."$R
	apt-get -y autoclean

	echo -e $A"Removiendo viejos archivos de configuración..."$R
	apt-get -y --force-yes purge $OLD

	echo -e $A"Removiendo viejos kernels..."$R
	borrar_oldkernel

	echo -e $A"Limpiando imágenes en miniatura..."$R
	rm -rf /home/*/.thumbnails/large/*
	rm -rf /home/*/.thumbnails/normal/*

	echo -e $A"Limpiando caché de Firefox..."$R
	rm -rf /home/*/.cache/mozilla/firefox/*

	echo -e $A"Limpiando caché de Google Chrome..."$R
	rm -rf /home/*/.cache/google-chrome/*
}

if [ $USER != root ]; then
  echo -e $R"Error: tenes que ser root"
  echo -e $A"Saliendo..."$R
  notify-send "Xubucleaner" "Tenés que ejecutar este programa como root"
  exit 0
fi
clear
notify-send "Xubucleaner" "Iniciando limpieza..."

echo -e $A"Limpiando las papeleras..."$R
rm -rf /home/*/.local/share/Trash/*
rm -rf /root/.local/share/Trash/*

echo -e $A"Arreglando paquetes rotos (si los hay)..."$R
apt-get -y --force-yes -f install
dpkg --configure -a
apt-get check

limpiar

echo -e $A"Obteniendo información de los repositorios..."$R
apt-get -y update

echo -e $A"Actualizándo programas..."$R
apt-get -y --force-yes upgrade

echo -e $A"Actualizándo kernel..."$R
apt-get -y --force-yes dist-upgrade

limpiar

echo -e $A"Script finalizado - edición por: Carlos Planchón!"$R
notify-send "Xubucleaner" "Listo!"
