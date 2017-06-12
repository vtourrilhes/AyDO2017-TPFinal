require_relative '../model/recurrenciaEvento'

class Evento

	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :id
  attr_accessor :nombre
	attr_accessor :calendario
	attr_accessor :recurrencia

	def initialize (id,nombre, ini, fin, calendario, *recurrencia)
		self.id = id
    self.nombre = nombre
		self.inicio = ini
		self.fin = fin		
		self.calendario = calendario
		self.recurrencia = recurrencia
	end

	def actualizarEvento (nuevoInicio, nuevoFin)
		self.inicio = nuevoInicio
		self.fin = nuevoFin
	end

end