
require_relative '../model/evento'
require_relative '../model/recurrenciaEvento'

class GenerarRecurrencia

	attr_accessor :eventos

	def validarEvento (eventoNuevo,eventoActual)
		
		result = true
		
		if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.inicio
			result = false
			#CASO A
		end
		
		if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.fin
			result = false
			#CASO B
		end
		
		if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.inicio
			result = false
			#CASO C
		end
		
		if eventoNuevo.inicio < eventoActual.inicio and eventoNuevo.fin > eventoActual.fin
			result = false
			#CASO D
		end
		
		if !result
			raise NameError.new("Hay evento solapado")
		end
		
		return result
	end
	
	def crearEventosRecurrentes (calendario,eventoNuevo, recurrenciaEvento)
		
		self.eventos = {}
		
		#Traigo todos los eventos que tengo actualmente en el calendario
		eventosCalendario = calendario.obtenerEventos()
		
		#Eventos para cargar
		#self.eventos[eventoNuevo.inicio] = eventoNuevo
		
		#Tiempo del evento, recurrencia y frecuencia
		tiempo_evento = eventoNuevo.fin-eventoNuevo.inicio
		recurrencia = eventoNuevo.recurrencia
		frecuencia = recurrencia.peridodDeRepeticion
		
		#Flags de While
		fecha_fin = recurrencia.fin
		fecha_inicio = eventoNuevo.inicio
		
		#Primer evento a cargar
		fecha_inicio = fecha_inicio+frecuencia
		
		index = 1
		
		while (fecha_inicio < fecha_fin)					
			
			evento = Evento.new(eventoNuevo.id +"_"+ index.to_s, eventoNuevo.nombre, fecha_inicio, fecha_inicio+tiempo_evento)
			
			#Itero entre los eventos actuales y el nuevo para ver que no se solape
			eventosCalendario.values.each do |eventoCalendario|
				validarEvento (evento,eventoCalendario)
				#Si no valida, tira excepcion y anula toda la recurrencia
			end

			#Validado OK , lo agrego
			self.eventos[eventoNuevo.inicio] = evento
			fecha_inicio = fecha_inicio+frecuencia			
		end
		
		#Retorno los nuevos eventos
		return eventos
		
	end

end