require_relative '../model/frecuenciaRecurrencia'

class Recurrencia

	attr_accessor :fin
	attr_accessor :frecuencia

	def initialize(fin, frecuencia)
		self.fin = fin
		self.frecuencia = frecuencia
	end

end