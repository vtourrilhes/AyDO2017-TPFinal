# Validador de Calendario

require_relative '../model/repositorioCalendarios'

class ValidadorDeCalendario
  
  def initialize()
    
  end

  def existe_calendario(repositorio,nombreCalendario)
  	if repositorio.estaCalendario? nombreCalendario
  		raise NameError.new("Ya existe un calendario con ese nombre o el nombre ingresado es invalido")
  	end
  end
  
  def no_existe_calendario(repositorio,nombreCalendario)
    raise NameError.new("Si existe el calendario") unless repositorio.estaCalendario? nombreCalendario
  end

end