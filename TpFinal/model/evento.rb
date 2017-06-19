require_relative '../model/recurrencia_evento'

class Evento

	attr_reader :id
	attr_accessor :inicio
	attr_accessor :fin
	attr_accessor :nombre
	attr_accessor :calendario
	attr_accessor :recurrencia

	def initialize (id, nombre, ini, fin, calendario, *recurrencia)
		@id = id
		@nombre = nombre
		@inicio = ini
		@fin = fin
		@calendario = calendario
		@recurrencia = recurrencia
	end

	def actualizar_evento (nuevo_inicio, nuevo_fin)
		@inicio = nuevo_inicio
		@fin = nuevo_fin
	end
end