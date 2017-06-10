  # Validador de Evento

require_relative '../model/calendario'

class ValidadorDeEvento
  
  def initialize()
    
  end

  def validarDuracionEvento(inicio, fin)
    result = ((fin - inicio) >= 0) && ((fin - inicio)/3600 <= 72) 
    
    if !result
      raise IOError.new("El evento excede la duración máxima de 72 horas")
    end

    return result
  end
  
  def validarExisteEvento(id_evento,calendario)
  	result = calendario.estaEvento? id_evento
    
    if !result
      raise IOError.new("El evento ya existe")
    end

    return result
  end

end