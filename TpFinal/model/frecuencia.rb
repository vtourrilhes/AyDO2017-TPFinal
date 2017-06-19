class Frecuencia

	attr_accessor :nombre
	attr_accessor :periodo_de_repeticion

	def initialize(nombre, periodo_de_repeticion)
		self.nombre = nombre
		self.periodo_de_repeticion = periodo_de_repeticion
	end
end