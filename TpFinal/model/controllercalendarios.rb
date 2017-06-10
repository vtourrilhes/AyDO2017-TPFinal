require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'
require_relative '../model/validadorDeJson'
require 'json'

class ControllerCalendarios

  attr_accessor :repositoriocalendarios

  def initialize()  
    self.repositoriocalendarios = RepositorioCalendarios.new
  end
  
  def agregarCalendario(calendario)    
    self.repositoriocalendarios.agregarCalendario(calendario)
  end

  def crearCalendario(parametrosCalendario)
    
    validador = ValidadorDeJSON.new
    validador.validar_parametros_calendario(parametrosCalendario)
    
    nombreCalendario = params[:nombre]
    
    return self.repositoriocalendarios.crearCalendario(nombreCalendario)
  end
  
  def obtenerCalendario(nombreCalendario)
    return self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
  end
  
  def obtenerCalendarios()
    return self.repositoriocalendarios.obtenerCalendarios()
  end

  def estaCalendario?(id_Calendario)
    return self.repositoriocalendarios.estaCalendario? id_Calendario
  end

end