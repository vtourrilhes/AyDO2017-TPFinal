require_relative '../model/calendario'
require_relative '../model/evento'

class GestorCalendario

  attr_accessor :calendarios

  def initialize()  
    self.calendarios = {}
  end
  
  def agregarCalendario(calendario)
    self.calendarios[calendario.nombre] = calendario
  end

  def crearCalendario(nombreCalendario)
    calendario = Calendario.new(nombreCalendario.downcase)
    agregarCalendario(calendario)

    return self.calendarios[id_Calendario]
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.calendarios[nombreCalendario]
  end

  def estaCalendario?(id_Calendario)
    return self.calendarios.key? id_Calendario
  end

  def crearEvento(nuevoInicio, nuevoFIn, nombreEvento, nombreCalendario)
    id_Calendario = nombreCalendario

    if estaCalendario?(id_Calendario)
      calendario = obtenerCalendario(id_Calendario)
      id_evento = nombreEvento.downcase      
      if !(calendario.estaEvento?(id_evento))
        evento = Evento.new(nuevoInicio, nuevoFIn, id_evento, calendario)
        calendario.agregarEvento(evento);
      else        
        raise NameError.new("Ya existe un evento con ese nombre")
      end
    else
      raise NameError.new("Calendario inexistente")
    end    
  end

end