#!/usr/bin/env python
# -*- coding: utf-8 -*-

from gi.repository import Gtk
import os

class Calculadora(Gtk.Window):
	def __init__(self):

		Gtk.Window.__init__(self)

		fila = Gtk.HBox()

#INTENTO DE MENÚ

#USÉ ESTA PARTE PARA PROBAR LOS OBJETOS DE GTK

#		def menu():
#			menu = Gtk.MenuBar("ASD")
#			menu.connect("clicked", self.boton_clicked)
#			ventana.add(menu)
#
#		def boton_menu():
#			boton = Gtk.MenuButton
#			boton.connect("clicked", self.boton_clicked)
#			menu.add(boton_menu)

#CLOSED

		def elboton(x):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			fila.add(boton)

#

##ACA VA LA PANTALLITA DE LA CALCULADORA

		for x in range(1,4):
			elboton(x)

		elboton("+")
		elboton("undo")
		elboton("clear")

	#ACA DEBERÍA HABER UN "ENTER"

		for x in range(5,8):
			elboton(x)

		elboton("*")
		elboton("(")
		elboton(")")

	#ACA DEBERÍA HABER OTRO "ENTER"

		for x in range(6,10):
			elboton(x)

		elboton("-")
		elboton("x²")
		elboton("TIC")

	#ACA DEBERÍA HABER OTRO "ENTER

		elboton("0")
		elboton(",")
		elboton("%")
		elboton("+")
		elboton("=")

#VENTANA

		ventana = Gtk.Window()
		ventana.set_icon_from_file(os.path.join("icono.png"))
		ventana.set_title("Calculadora")
		ventana.set_size_request(300,200)
		ventana.connect("destroy",Gtk.main_quit)
#		ventana.add(menu)
		ventana.add(fila)
		ventana.show_all()

	def main(self):
		Gtk.main()

	def boton_clicked(self, widget):
		print widget.get_label()

calc = Calculadora()
calc.main()
