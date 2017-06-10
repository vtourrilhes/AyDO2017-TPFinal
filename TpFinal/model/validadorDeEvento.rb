  # Validador de Evento

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

end