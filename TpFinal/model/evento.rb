class Evento

	attr_reader :id
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :nombre
	attr_accessor :calendario
	attr_accessor :recurrencia

	def initialize (id, nombre, fecha_inicio, fecha_fin, calendario, *recurrencia)
		@id = id
		@nombre = nombre
		@inicio = fecha_inicio
		@fin = fecha_fin
		@calendario = calendario
		@recurrencia = recurrencia
	end

	def actualizar_evento (fecha_inicio, fecha_fin)
		@inicio = fecha_inicio
		@fin = fecha_fin
	end
end