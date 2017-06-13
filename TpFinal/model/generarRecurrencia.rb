
require_relative '../model/evento'
require_relative '../model/recurrenciaEvento'
require_relative '../model/validadorDeEvento'
require 'date'

class GeneradorDeRecurrencia

	attr_accessor :eventos

	def crearEventosRecurrentes (calendario,eventoNuevo, recurrenciaEvento)
		
		self.eventos = {}
    
    validador = ValidadorDeEvento.new
		
		
		eventosCalendario = {}
		
		
		calendario.obtenerEventos().each do |eventoCalendario|
				eventosCalendario[eventoCalendario.nombre]=eventoCalendario
			end
		
		
		tiempo_evento = eventoNuevo.fin-eventoNuevo.inicio
		recurrencia = recurrenciaEvento
		frecuencia = recurrencia.frecuencia.peridodDeRepeticion*(24*3600)
		
		
		fecha_fin = recurrencia.fin
		fecha_inicio = eventoNuevo.inicio
		
		validador.validarFrecuencia(frecuencia)
		validador.validarFechas(fecha_inicio,fecha_inicio+frecuencia)
		
		
		fecha_inicio = fecha_inicio+frecuencia
		  
		index = 1
		
		while (fecha_inicio <= fecha_fin)					
			
      eventoId = eventoNuevo.id + index.to_s
      fechaFinEventoNuevo = fecha_inicio+tiempo_evento
      
			evento = Evento.new(eventoId, eventoNuevo.nombre, fecha_inicio, fechaFinEventoNuevo,calendario)
			
			
			eventosCalendario.values.each do |eventoCalendario|
				validador.validarEvento(evento,eventoCalendario)
				
			end

			
			self.eventos[eventoId] = evento
			validador.validarFechas(fecha_inicio,fecha_inicio+frecuencia)
			fecha_inicio = fecha_inicio+frecuencia
      index = index + 1
		end
		
		
		return self.eventos.values
		
	end

end