  # Validador de Evento

require_relative '../model/calendario'
require 'date'

class ValidadorDeEvento  

  def validarDuracionEvento(inicio, fin)
    result = ((fin - inicio) >= 0) && ((fin - inicio)/3600 <= 72) 
    
    if !result
      raise NameError.new("El evento excede la duracion maxima de 72 horas")
    end

    return result
  end
  
  def validarFechas(inicio, fin)
    result = ((fin - inicio) > 0) 
    
    if !result
      raise NameError.new("Fecha Final menor que Inicial")
    end
   return result
  end
  
    def validarFrecuencia(dias)
    result = (dias > 0) 
    
    if !result
      raise NameError.new("La frecuencia no es valida")
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
    
    raise TypeError unless eventoNuevo.inicio.is_a? Time
    raise TypeError unless eventoNuevo.fin.is_a? Time
    raise TypeError unless eventoActual.inicio.is_a? Time
    raise TypeError unless eventoActual.fin.is_a? Time
		
    if eventoNuevo.inicio < eventoActual.inicio and eventoNuevo.fin > eventoActual.fin
			result = false
			#CASO D
      raise NameError.new("Hay evento solapado - caso D " + eventoNuevo.inicio.to_s)
		end
    
    	if eventoActual.inicio < eventoNuevo.inicio and eventoActual.fin > eventoNuevo.fin
			result = false
			#CASO B
        raise NameError.new("Hay evento solapado - caso B " + eventoNuevo.inicio.to_s)
		end
    
    if (eventoNuevo.inicio > eventoActual.inicio and eventoActual.fin > eventoNuevo.inicio and eventoNuevo.fin > eventoActual.fin)
			result = false
			#CASO A
      raise NameError.new("Hay evento solapado - caso A " + eventoNuevo.inicio.to_s)
		end
    
    if (eventoActual.inicio > eventoNuevo.inicio and eventoNuevo.fin > eventoActual.inicio and eventoActual.fin > eventoNuevo.fin)
			result = false
			#CASO C
      raise NameError.new("Hay evento solapado - caso C " + eventoNuevo.inicio.to_s)
		end
		
		if !result
			raise NameError.new("Hay evento solapado")
		end
		
		return result
	end

end