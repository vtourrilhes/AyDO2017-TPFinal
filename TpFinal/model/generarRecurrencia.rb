
require_relative '../model/evento'
require_relative '../model/recurrenciaEvento'
require_relative '../model/validadorDeEvento'

class GenerarRecurrencia

	attr_accessor :eventos

	def crearEventosRecurrentes (calendario,eventoNuevo, recurrenciaEvento)
		
		self.eventos = {}
    
    validador = ValidadorDeEvento.new
		
		#Traigo todos los eventos que tengo actualmente en el calendario
		eventosCalendario = calendario.obtenerEventos()
		
		#Eventos para cargar
		#self.eventos[eventoNuevo.inicio] = eventoNuevo
		
		#Tiempo del evento, recurrencia y frecuencia
		tiempo_evento = eventoNuevo.fin-eventoNuevo.inicio
		recurrencia = recurrenciaEvento
		frecuencia = recurrencia.frecuencia.peridodDeRepeticion
		
		#Flags de While
		fecha_fin = recurrencia.fin
		fecha_inicio = eventoNuevo.inicio
		
		#Primer evento a cargar
		fecha_inicio = fecha_inicio+frecuencia
		
		index = 1
		
		while (fecha_inicio < fecha_fin)					
			
      eventoId = eventoNuevo.id +'_'+ index.to_s
      fechaFinEventoNuevo = fecha_inicio+tiempo_evento
      
			evento = Evento.new(eventoId, eventoNuevo.nombre, fecha_inicio, fechaFinEventoNuevo)
			
			#Itero entre los eventos actuales y el nuevo para ver que no se solape
			eventosCalendario.values.each do |eventoCalendario|
				validador.validarEvento(evento,eventoCalendario)
				#Si no valida, tira excepcion y anula toda la recurrencia
			end

			#Validado OK , lo agrego
			self.eventos[eventoNuevo.inicio] = evento
			fecha_inicio = fecha_inicio+frecuencia			
		end
		
		#Retorno los nuevos eventos
		return self.eventos
		
	end

end