#!/usr/bin/env python
# -*- coding: utf-8 -*-

from gi.repository import Gtk
import os

class Calculadora(Gtk.Window):
	def __init__(self):

		Gtk.Window.__init__(self)

		columna = Gtk.VBox()
		fila = Gtk.HBox()
		fila2 = Gtk.HBox()
		fila3 = Gtk.HBox()
		fila4 = Gtk.HBox()

#MENU
#PANTALLA

		columna.add(fila)
		columna.add(fila2)
		columna.add(fila3)
		columna.add(fila4)

		def elboton(x):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			fila.add(boton)

		for x in range(1,4):
			elboton(x)

		elboton("+")
		elboton("undo")
		elboton("clear")

		def elboton(x):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			fila2.add(boton)


		for x in range(5,8):
			elboton(x)

		elboton("*")
		elboton("(")
		elboton(")")

		def elboton(x):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			fila3.add(boton)

		for x in range(6,10):
			elboton(x)

		elboton("-")
		elboton("x²")
		elboton("✓")

		def elboton(x):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			fila4.add(boton)

		elboton("0")
		elboton(",")
		elboton("/")
		elboton("+")
		elboton("=")

		self.set_icon_from_file(os.path.join("icono.png"))
		self.set_title("Calculadora")
		self.set_size_request(300,200)
		self.connect("destroy",Gtk.main_quit)
		self.add(columna)
		self.add(pantalla)
		self.show_all()

	def main(self):
		Gtk.main()

	def boton_clicked(self, widget):
		print widget.get_label()

calc = Calculadora()
calc.main()
