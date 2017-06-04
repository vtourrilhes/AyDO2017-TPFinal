class Evento

	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :id
	attr_accessor :nombre
	attr_accessor :calendario

	def initialize (id)
		self.id = id
	end

	def initialize (id, ini, fin, nombre, calendario)
		self.id = id
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