class Frecuencia

	attr_accessor :nombre
	attr_accessor :peridodDeRepeticion

	def initialize(nombre, peridodDeRepeticion)
		self.nombre = nombre
		self.peridodDeRepeticion = peridodDeRepeticion
	end
end