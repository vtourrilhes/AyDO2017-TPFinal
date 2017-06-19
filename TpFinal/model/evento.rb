require_relative '../model/recurrencia_evento'

class Evento

	attr_reader :id
	attr_accessor :inicio
	attr_accessor :fin
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

	def actualizar_evento (nuevo_inicio, nuevo_fin)
		self.inicio = nuevo_inicio
		self.fin = nuevo_fin
	end

end