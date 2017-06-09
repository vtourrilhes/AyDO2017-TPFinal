require_relative '../model/evento'

class Calendario  
 
  attr_accessor :eventos
  attr_accessor :nombre

  def initialize (nombre)  
    self.nombre = nombre 
    self.eventos = {}
  end   

  def agregarEvento(nuevoEvento)   	
  	self.eventos[nuevoEvento.nombre] = nuevoEvento
  end

  def obtenerEvento(id_evento)
  	return self.eventos[id_evento]
  end

  def estaEvento?(id_evento)
  	return self.eventos.key? id_evento
  end

  def crearEvento(nombreEvento, nuevoInicio, nuevoFin)
    id_evento = nombreEvento.downcase      
    
    if !estaEvento?(id_evento)
      validarDuracionEvento(nuevoInicio, nuevoFin)
      evento = Evento.new(id_evento, nuevoInicio, nuevoFin, self)
      agregarEvento(evento);
    else        
      raise NameError.new("Ya existe un evento con ese nombre")
    end 
  end

  def validarDuracionEvento(inicio, fin)
    result = ((fin - inicio) >= 0) && ((fin - inicio)/3600 <= 72) 
    
    if !result
      raise IOError.new("El evento excede la duración máxima de 72 horas")
    end

    return result
  end
 
end