  # Validador de Evento

require_relative '../model/calendario'

class ValidadorDeEvento  

  def validarDuracionEvento(inicio, fin)
    result = ((fin - inicio) >= 0) && ((fin - inicio)/3600 <= 72) 
    
    if !result
      raise NameError.new("El evento excede la duración máxima de 72 horas")
    end

    return result
  end
  
  def validarExisteEvento(id_evento,calendario)
    if calendario.estaEvento? id_evento
      raise NameError.new("El evento ya existe")
    end
  end

  def validarActualizacionEvento(evento)
    if evento.nil?
      raise NameError.new("El evento ha actualizar no existe")
    end
  end
  
  def validarNoExisteEvento(id_evento,calendario)
    if !(calendario.estaEvento? id_evento)
      raise NameError.new("El evento no existe")
    end
  end
  
  def validarEvento (eventoNuevo,eventoActual)
		
		result = true
		
    if eventoNuevo.inicio < eventoActual.inicio and eventoNuevo.fin > eventoActual.fin
			result = false
			#CASO D
		end
    
    	if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.fin
			result = false
			#CASO B
		end
    
    if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.inicio
			result = false
			#CASO C
		end
		
=begin

    if (eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.inicio and eventoActual.fin < eventoNuevo.fin)
			result = false
			#CASO A
		end
	
		
		if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.inicio
			result = false
			#CASO C
		end
		
		
=end
		if !result
			raise NameError.new("Hay evento solapado")
		end
		
		return result
	end

end