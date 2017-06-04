class Evento

	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :nombre
	attr_accessor :calendario

	def initialize (ini, fin, nombre, calendario)
		self.inicio = ini
		self.fin = fin
		self.nombre = nombre
		self.calendario = calendario
	end

	def actualizarEvento (nuevoInicio, nuevoFin)
		self.inicio = nuevoInicio
		self.fin = nuevoFin
	end

end