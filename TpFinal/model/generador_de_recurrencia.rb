require_relative '../model/evento'
require_relative '../model/recurrencia_evento'
require_relative '../model/validador_de_evento'
require 'date'

class GeneradorDeRecurrencia

	attr_accessor :eventos

	def crear_eventos_recurrentes(calendario, evento, recurrencia)

		@eventos = {}
		validador = ValidadorDeEvento.new
		eventos_calendarios = {}

		calendario.obtener_eventos.each do |evento_calendario|
			eventos_calendarios[evento_calendario.id]=evento_calendario
		end

		tiempo_evento = evento.fin - evento.inicio
		recurrencia = recurrencia
		frecuencia = recurrencia.frecuencia.periodo_de_repeticion*(24*3600)

		fecha_fin = recurrencia.fin
		fecha_inicio = evento.inicio

		validador.validarFrecuencia(frecuencia)
		validador.validarFechas(fecha_inicio,fecha_inicio + frecuencia)

		fecha_inicio = fecha_inicio + frecuencia

		index = 1

		while fecha_inicio <= fecha_fin do

			evento_id = evento.id + index.to_s
			fecha_fin_evento_nuevo = fecha_inicio + tiempo_evento

			evento = Evento.new(evento_id, evento.nombre, fecha_inicio, fecha_fin_evento_nuevo,calendario)


			eventos_calendarios.values.each do |eventoCalendario|
				validador.validarEvento(evento,eventoCalendario)

			end

			@eventos[evento_id] = evento
			validador.validarFechas(fecha_inicio,fecha_inicio+frecuencia)
			fecha_inicio = fecha_inicio+frecuencia
			index = index + 1
		end

		@eventos.values

	end

end