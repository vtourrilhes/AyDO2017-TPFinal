require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'
require_relative '../model/validadorDeJson'
require_relative '../model/validadorDeCalendario'
require 'json'

class ControllerCalendarios

  attr_accessor :repositoriocalendarios

  def initialize()  
    self.repositoriocalendarios = RepositorioCalendarios.new
  end
  
  def crearCalendario(parametrosCalendario)
    
    validador = ValidadorDeJSON.new
    validador.validar_parametros_calendario(parametrosCalendario)
    
    nombreCalendario = parametrosCalendario[:nombre]
    
    return self.repositoriocalendarios.crearCalendario(nombreCalendario)
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.repositoriocalendarios.obtenerCalendarioJSON(nombreCalendario)
  end
  
  def obtenerCalendarios()
    return self.repositoriocalendarios.obtenerCalendariosJSON()
  end
  
  def eliminarCalendario(nombreCalendario)
    self.repositoriocalendarios.eliminarCalendario(nombreCalendario)
  end
  
  def crearEvento(parametrosEvento)
  
     validador = ValidadorDeJSON.new
      validador.validar_parametros_evento(parametrosCalendario)
    
      nombreCalendario = parametrosEvento[:calendario]
      
      validador = ValidadorDeCalendario.new
      validador.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      
      nombreEvento = parametrosEvento[:nombre]
      inicio = parametrosEvento[:inicio]
      fin = parametrosEvento[:fin]
    
      calendario.crearEvento(nombreEvento,inicio,fin)
    
      self.repositoriocalendarios.agregarCalendario(calendario)

  end

end