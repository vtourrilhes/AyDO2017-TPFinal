require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'
require_relative '../model/validadorDeJson'
require_relative '../model/validadorDeCalendario'
require_relative '../model/validadorDeEvento'
require 'json'

class ControllerCalendarios

  attr_accessor :repositoriocalendarios

  def initialize()  
    self.repositoriocalendarios = RepositorioCalendarios.new
  end
  
  def crearCalendario(datos_json)
    
    parametrosCalendario = {
      nombre: datos_json["nombre"]
    }
    
    validador = ValidadorDeJSON.new
    validador.validar_parametros_calendario(parametrosCalendario)
    
    nombreCalendario = parametrosCalendario[:nombre].downcase
    
    validador = ValidadorDeCalendario.new
    validador.existe_calendario(self.repositoriocalendarios,nombreCalendario)
    
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
  
  def crearEvento(datos_json)
  
    datos_recurrencia = JSON.parse datos_json["recurrencia"]
    
    parametrosEvento = {
      calendario: datos_json["calendario"],
      id: datos_json["id"],
      nombre: datos_json["nombre"],
      inicio: datos_json["inicio"],
      fin: datos_json["fin"],
      
      frecuencia: datos_recurrencia["frecuencia"],
      frecuencia_fin: datos_recurrencia["fin"]
      
    }
    
     validador = ValidadorDeJSON.new
      validador.validar_parametros_evento(parametrosCalendario)
    
      nombreCalendario = parametrosEvento[:calendario]
      
      validador = ValidadorDeCalendario.new
      validador.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      
      nombreEvento = parametrosEvento[:nombre].downcase
      inicio = parametrosEvento[:inicio]
      fin = parametrosEvento[:fin]
    
      validador = ValidadorDeEvento.new
      validador.validarExisteEvento(nombreEvento,calendario)
      validador.validarDuracionEvento(nuevoInicio, nuevoFin)
    
      calendario.crearEvento(nombreEvento,inicio,fin)
    
      self.repositoriocalendarios.agregarCalendario(calendario)

  end
  
    def actualizarEvento(datos_json)
  
      parametrosCalendario = {
      calendario: datos_json["calendario"],
      nombre: datos_json["nombre"],
      inicio: datos_json["inicio"],
      fin: datos_json["fin"]
    } 
      
     validador = ValidadorDeJSON.new
      validador.validar_parametros_evento(parametrosCalendario)
    
      nombreCalendario = parametrosEvento[:calendario]
      
      validador = ValidadorDeCalendario.new
      validador.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      
      nombreEvento = parametrosEvento[:nombre].downcase
      inicio = parametrosEvento[:inicio]
      fin = parametrosEvento[:fin]
    
      validador = ValidadorDeEvento.new
      validador.validarNoExisteEvento(nombreEvento,calendario)
      validador.validarDuracionEvento(nuevoInicio, nuevoFin)
    
      calendario.actualizarEvento(nombreEvento,inicio,fin)
    
      self.repositoriocalendarios.agregarCalendario(calendario)

  end
  
  def eliminarEvento(parametrosEvento)
  
     validador = ValidadorDeJSON.new
      validador.validar_parametros_evento(parametrosCalendario)
    
      nombreCalendario = parametrosEvento[:calendario]
      
      validador = ValidadorDeCalendario.new
      validador.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      
      nombreEvento = parametrosEvento[:nombre].downcase
    
      validador = ValidadorDeEvento.new
      validador.validarNoExisteEvento(nombreEvento,calendario)
    
      calendario.eliminarEvento(nombreEvento)
    
      self.repositoriocalendarios.agregarCalendario(calendario)

  end
  
  def obtenerEvento(nombreEvento)
    #return self.repositoriocalendarios.obtenerCalendarioJSON(nombreCalendario)
  end
  
  def obtenerEventos(nombreCalendario)
    calendarios = self.repositoriocalendarios.obtenerCalendarios()
    return calendarios.obtenerEventos().to_json
  end

end