require_relative '../model/calendario'

class RepositorioCalendarios

  attr_accessor :calendarios

  def initialize()  
    self.calendarios = {}
  end
  
  def agregarCalendario(calendario)    
    self.calendarios[calendario.nombre] = calendario
  end

  def crearCalendario(nombreCalendario)
    if !(estaCalendario? nombreCalendario.downcase)
      calendario = Calendario.new(nombreCalendario.downcase)
      agregarCalendario(calendario)
    else
      raise NameError.new("Ya existe un calendario con ese nombre")
    end

    return self.calendarios[nombreCalendario]
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.calendarios[nombreCalendario]
  end
  
  def obtenerCalendarioJSON(nombreCalendario)
    return self.calendarios[nombreCalendario].to_json
  end
  
  def obtenerCalendarios()
    return self.calendarios
  end
  
  def obtenerCalendariosJSON()
    return self.calendarios.to_json
  end

  def estaCalendario?(id_Calendario)
    return self.calendarios.key? id_Calendario
  end
  
  def eliminarCalendario(nombreCalendario)
    self.calendarios.delete(nombreCalendario)
  end

end