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
    
      calendario = Calendario.new(nombreCalendario)
      agregarCalendario(calendario)
    
      return self.calendarios[nombreCalendario]
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.calendarios[nombreCalendario]
  end
<<<<<<< HEAD
    
  def obtenerCalendarios()
    return self.calendarios.values
  end
  
=======
  
  def obtenerCalendarios()
    return self.calendarios.values
  end

>>>>>>> 67d1959ff7b05caf023c514e72e0a8fa6134b1d3
  def estaCalendario?(id_Calendario)
    return self.calendarios.key? id_Calendario
  end
  
  def eliminarCalendario(nombreCalendario)
    self.calendarios.delete(nombreCalendario)
  end

end