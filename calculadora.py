#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math

print "\t\t\t///////////////////"
print "\t\t\t//  CALCULADORA  //"
print "\t\t\t///////////////////"
print ""
print "Pone 1 para sumar\n"
print "Pone 2 para restar\n"
print "Pone 3 para multiplicar\n"
print "Pone 4 para dividir\n"

def sumar(a,b):
	return int(a)+int(b)

def restar(a,b):
	return int(a)-int(b)

def multiplicar(a,b):
	return int(a)*int(b)

def dividir(a,b):
	return int(a)/int(b)

operacion = input("> ")

if operacion == 1:
	print ("Elegiste sumar\n")
	a = raw_input("Pone el primer número: ")
	b = raw_input("Pone el segundo número: ")
	print sumar(a,b)
elif operacion == 2:
	print ("Elegiste restar\n")
	a = raw_input("Pone el primer número: ")
	b = raw_input("Pone el segundo número: ")
	print restar(a,b)
elif operacion == 3:
	print ("Elegiste multiplicar\n")
	a = raw_input("Pone el primer número: ")
	b = raw_input("Pone el segundo número: ")
	print multiplicar(a,b)
elif operacion == 4:
	print ("Elegiste dividir\n")
	a = raw_input("Pone el primer número: ")
	b = raw_input("Pone el segundo número: ")
	print dividir(a,b)
elif operacion == 44:
	print ("Tené cuidado!!!\nSi no haces cosas útiles para la humanidad, algo malo podría pasarte...")
else:
	print ("Operación no válida")

print ("\n\n\n\t\t\t//////////////////////////////////////////////////////////////////////")
print ("\t\t\t//         Calculadora - Por: Carlos A. Planchón - 11/5/2014        //")
print ("\t\t\t//  Si te gustó perfecto, si no, no hay mucho que podamos hacer :D  //")
print ("\t\t\t//////////////////////////////////////////////////////////////////////")
