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
    calendario = Calendario.new(nombreCalendario.downcase)
    agregarCalendario(calendario)

    return self.calendarios[nombreCalendario]
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.calendarios[nombreCalendario]
  end

  def estaCalendario?(id_Calendario)
    return self.calendarios.key? id_Calendario
  end

end