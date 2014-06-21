#!/usr/bin/env python
# -*- coding: utf-8 -*-

import gtk

class bot(gtk.Window):
	def __init__(self):
		self.altura = 1.78
		print "Soy una persona que vive en el planeta tierra pero vine de Marte"

	def texto(self,mensaje):
		print mensaje

carlos = bot()
matias = bot()

carlos.texto("Hola")

matias.texto("Hola,Pedro")

print "Soy Carlos y mido: ",carlos.altura
print "Soy Matias y mido: " ,matias.altura
