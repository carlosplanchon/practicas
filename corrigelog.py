#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import system
system("touch convertido.log")

log=open("latest.log", "r")
convertido=open("convertido.log", "w")
for linea in log.readlines():
	if linea[0] == "[":
		hora = int(linea[1:3])
		hora = hora - 5
		hora = str(hora)
		hora = hora.replace('-1','23')
		hora = hora.replace('-2','22')
		hora = hora.replace('-3','21')
		hora = hora.replace('-4','20')
		hora = hora.replace('-5','19')
		if int(hora) < 10:
			hora = '0' + hora
		convertido.write("["+hora+linea[3:])
	else:
		convertido.write(linea)
		continue
log.close()
convertido.close()
