#!/usr/bin/env python
# -*- coding: utf-8 -*-

import gtk

class Calculadora(Gtk.Window):
	def __init__(self,numeros):
		Gtk.Window.__init__(self)

		caja = Gtk.Vbox()
		for x in range(0, 3):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			caja.add(boton)
		for x in range(4, 6):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			caja.add(boton)
		for x in range(7, 9):
			boton = Gtk.Button(str(x))
			boton.connect("clicked", self.boton_clicked)
			caja.add(boton)

		boton = Gtk.Button("+")
		boton.connect("clicked", self.boton_clicked)
		caja.add(boton)
		boton = Gtk.Button("-")
		boton.connect("clicked", self.boton_clicked)
		caja.add(boton)
		boton = Gtk.Button("*")
		boton.connect("clicked", self.boton_clicked)
		caja.add(boton)
		boton = Gtk.Button("/")
		boton.connect("clicked", self.boton_clicked)
		caja.add(boton)
		boton = Gtk.Button("=")
		boton.connect("clicked", self.boton_clicked)
		caja.add(boton)
		boton = Gtk.Button("Borrar")
		boton.connect("clicked", self.boton_clicked)
		caja.add(boton)


		self.add(caja)
		self.show_all()

		self.connect("delete-event", self.salir)

	def salir(self, widget, event):
		gtk.main_quit()

if __name__ == "__main__":
	calculadora = Calculadora()
gtk.main()
