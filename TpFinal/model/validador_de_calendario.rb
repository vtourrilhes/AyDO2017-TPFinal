# Validador de Calendario

require_relative '../model/repositorio_calendarios'

class ValidadorDeCalendario

  def existe_calendario(repositorio,nombreCalendario)
  	if repositorio.estaCalendario? nombreCalendario
  		raise NameError.new("Ya existe un calendario con ese nombre o el nombre ingresado es invalido")
  	end
  end
  
  def no_existe_calendario(repositorio,nombreCalendario)
    if !(repositorio.estaCalendario? nombreCalendario)
      raise NameError.new("No existe el calendario al que se hace referencia")
    end
  end

end