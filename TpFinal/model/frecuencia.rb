class Frecuencia

	attr_accessor :nombre
	attr_accessor :periodo_repeticion

	def initialize(nombre, periodo_repeticion)
		@nombre = nombre
		@periodo_repeticion = periodo_repeticion
	end
end