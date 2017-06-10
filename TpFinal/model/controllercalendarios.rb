require_relative '../model/calendario'
require_relative '../model/repositoriocalendarios'

class ControllerCalendarios

  attr_accessor :repositoriocalendarios

  def initialize()  
    self.repositoriocalendarios = RepositorioCalendarios.new
  end
  
  def agregarCalendario(calendario)    
    self.repositoriocalendarios.agregarCalendario(calendario)
  end

  def crearCalendario(nombreCalendario)
    return self.repositoriocalendarios.crearCalendario(nombreCalendario)
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
  end

  def estaCalendario?(id_Calendario)
    return self.repositoriocalendarios.estaCalendario? id_Calendario
  end

end