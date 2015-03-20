#!/bin/bash
# -*- coding: utf-8 -*-

A='\033[1;33m'
R='\033[0;31m'
F='\033[0m'

function limpiar
{
	echo -e $A'Limpiando la cache apt...'$F
	apt-get -y clean

	echo -e $A'Eliminando paquetes huerfanos...'$F
	apt-get -y autoremove

	echo -e $A'Eliminando paquetes viejos...'$F
	apt-get -y autoclean

	echo -e $A'Removiendo viejos archivos de configuración...'$F
	apt-get -y --force-yes purge $(dpkg -l|grep '^rc'|awk '{print $2}')

	echo -e $A'Removiendo viejos kernels (si los hay)...'$F
	ls /boot/ | grep vmlinuz | sed 's@vmlinuz-@linux-image-@g' | sed '$d' | sed '$d' > /tmp/kernelList
	if [ -s /tmp/kernelList ]; then
		echo -e $A'Se eliminarán los siguientes kernels\n`cat /tmp/kernelList`'$F
		notify-send 'Xubucleaner' 'Se está operando sobre el kernel.'
		for I in `cat /tmp/kernelList`; do
			apt-get remove $I
			echo -e $A'Eliminando $I...'$F
		done
		rm -f /tmp/kernelList
		echo -e $A'Actualizando gestor de arranque...'$F
		update-grub
	fi

	echo -e $A'Limpiando imágenes en miniatura...'$F
	rm -rf /home/*/.thumbnails/large/*
	rm -rf /home/*/.thumbnails/normal/*

	echo -e $A'Limpiando caché de Firefox...'$F
	rm -rf /home/*/.cache/mozilla/firefox/*

	echo -e $A'Limpiando caché de Google Chrome...'$F
	rm -rf /home/*/.cache/google-chrome/*

	echo -e $A'Limpiando archivos temporales...'$F
	rm -rf /tmp/*
}

if [ $USER != root ]; then
  echo -e $R'Error: tenes que ser root'
  echo -e $A'Saliendo...'$F
  notify-send 'Xubucleaner' 'Tenés que ejecutar este programa como root'
  exit 0
fi
clear
notify-send 'Xubucleaner' 'Iniciando limpieza...'

echo -e $A'Limpiando las papeleras...'$F
rm -rf /home/*/.local/share/Trash/*
rm -rf /root/.local/share/Trash/*

limpiar

echo -e $A'Arreglando paquetes rotos (si los hay)...'$F
apt-get -y --force-yes -f install
dpkg --configure -a
apt-get check

echo -e $A'Obteniendo información de los repositorios...'$F
apt-get -y update

echo -e $A'Actualizándo programas...'$F
apt-get -y --force-yes upgrade

echo -e $A'Actualizándo kernel...'$F
apt-get -y --force-yes dist-upgrade

limpiar

echo -e $A'Script finalizado - edición por: Carlos A. Planchón!'$F
notify-send 'Xubucleaner' 'Listo!'
