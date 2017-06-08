class Evento

	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :nombre
	attr_accessor :calendario

	def initialize (nombre, ini, fin, calendario)
		self.nombre = nombre
		self.inicio = ini
		self.fin = fin		
		self.calendario = calendario
	end

	def actualizarEvento (nuevoInicio, nuevoFin)
		self.inicio = nuevoInicio
		self.fin = nuevoFin
	end

	def obtenerJsonString
		{id_evento: nombre, fecha_inicio: inicio, fecha_fin: fin}		
	end

end