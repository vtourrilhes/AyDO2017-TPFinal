class JsonCalendario

	attr_accessor :datosJson

	def initialize(json)
		self.datosJson = json
	end

	def obtenerNombreCalendario
		return datosJson['nombre'].downcase
	end
end