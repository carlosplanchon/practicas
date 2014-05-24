#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import system

system("clear")

print chr(27)+"[33;43m"+"\t\t\tMM"+chr(27)+"[34;44m"+"MMMMMMMMMMMMM"+chr(27)+"[33;43m"+"MM"+chr(27)+"[0m"
print chr(27)+"[34;44m"+"\t\t\tMM"+chr(27)+"[37;47m"+"MMMMMMMMMMMMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[0m"
print chr(27)+"[34;44m"+"\t\t\tMM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[0m"
print chr(27)+"[34;44m"+"\t\t\tMM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[0m"
print chr(27)+"[34;44m"+"\t\t\tMM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[0m"
print chr(27)+"[34;44m"+"\t\t\tMM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MMMMMMM"+chr(27)+"[37;47m"+"MMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[0m"
print chr(27)+"[34;44m"+"\t\t\tMM"+chr(27)+"[37;47m"+"MMMMMMMMMMMMM"+chr(27)+"[34;44m"+"MM"+chr(27)+"[0m"
print chr(27)+"[33;43m"+"\t\t\tMM"+chr(27)+"[34;44m"+"MMMMMMMMMMMMM"+chr(27)+"[33;43m"+"MM"+chr(27)+"[0m"

print"\t\t\t/////////////////\n\t\t\t//  URUHELPER  //\n\t\t\t/////////////////"

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

comando=raw_input("> ")

if comando == "stats":
	contador = 0
	contador2 = 0
	contador3 = 0
	contador4 = 0
	contador5 = 0
	log = open("convertido.log")
	linea = log.readlines()
	for linea in linea:
    		palabras = linea.split(" ")
    		for palabra in palabras:
        		if palabra=="issued":
        			hora = linea[1:9]
            			contador = contador+1
    			elif palabra=="Loaded":
        			hora2 = linea[1:9]
            			contador2 = contador2+1
    			elif palabra=="Removing":
        			hora3 = linea[1:9]
            			contador3 = contador3+1
    			elif palabra=="registered":
        			hora4 = linea[1:9]
            			contador4 = contador4+1
    			elif palabra=="[Netty":
        			hora5 = linea[1:9]
            			contador5 = contador5+1
	print "En este registro los usuarios:"
	print "\tejecutaron comandos {0} veces".format(contador)
	print "\t\tLa última vez a la hora " + hora
	print "\tHa habido {0} logueos".format(contador2)
	print "\t\tEl último fue a la hora " + hora2
	print "\tHa habido {0} deslogueos".format(contador3)
	print "\t\tEl último fue a la hora " + hora3
	print "\tSe han registrado {0} usuarios".format(contador4)
	print "\t\tEl último fue a la hora " + hora4
	print "\tLos usuarios han chateado {0} veces".format(contador5)
	print "\t\tEl último fue a la hora " + hora5
	system("mousepad convertido.log")
	log.close()
