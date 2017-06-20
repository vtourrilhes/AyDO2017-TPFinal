class Evento

	attr_reader :id
	attr_accessor :fecha_inicio
	attr_accessor :fecha_fin
	attr_accessor :nombre
	attr_accessor :calendario
	attr_accessor :recurrencia

	def initialize (id, nombre, fecha_inicio, fecha_fin, calendario, *recurrencia)
		@id = id
		@nombre = nombre
		@fecha_inicio = fecha_inicio
		@fecha_fin = fecha_fin
		@calendario = calendario
		@recurrencia = recurrencia
	end

	def actualizar_evento (fecha_inicio, fecha_fin)
		@fecha_inicio = fecha_inicio
		@fecha_fin = fecha_fin
	end
end