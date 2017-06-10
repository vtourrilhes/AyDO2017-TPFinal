# Validador de Calendario

require_relative '../model/repositorioCalendarios'

class ValidadorDeCalendario
  
  def initialize()
    
  end

  def existe_calendario(repositorio,nombreCalendario)
    raise NameError.new("No existe el calendario") unless !repositorio.estaCalendario? nombreCalendario
  end

end