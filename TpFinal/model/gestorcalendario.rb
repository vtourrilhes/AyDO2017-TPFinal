require_relative '../model/calendario'

class GestorCalendario

  def initialize()  
    @calendarios = {}
  end
  

  def crearCalendario(nombreCalendario)
    @calendarios[nombreCalendario] = Calendario.new(nombreCalendario)
    return @calendarios[nombreCalendario]
  end
  
  def obtenerCalendario(nombreCalendario)
    return @calendarios[nombreCalendario]
  end
  
  def obtenerCalendarios()
    return @calendarios
  end
  
  def borrarCalendario(nombreCalendario)
    return @calendarios.delete(nombreCalendario)
  end

end