require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'
require_relative '../model/persistidorDeDatos'
require_relative '../model/validadorDeJson'
require_relative '../model/validadorDeCalendario'
require_relative '../model/validadorDeEvento'
require 'json'

class ControllerCalendarios

  attr_accessor :repositoriocalendarios
  attr_accessor :persistidorDeDatos
  attr_accessor :validadorDeJson
  attr_accessor :validadorCalendario
  attr_accessor :validadorEvento

  def initialize()  
    self.repositoriocalendarios = RepositorioCalendarios.new    
    self.persistidorDeDatos = PersistidorDeDatos.new
    self.validadorCalendario = ValidadorDeCalendario.new
    self.validadorEvento = ValidadorDeEvento.new
    self.validadorDeJson = ValidadorDeJSON.new

    self.persistidorDeDatos.cargarDatosCalendarios(self.repositoriocalendarios) 
  end
  
  def crearCalendario(datos_json)
    nombreCalendario = datos_json['nombre'].downcase

    validadorCalendario.existe_calendario(self.repositoriocalendarios,nombreCalendario)
    calendario = self.repositoriocalendarios.crearCalendario(nombreCalendario)
    persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios)
    
    return calendario
  end
  
  def obtenerCalendario(nombreCalendario)
    calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
    return calendario
  end
  
  def obtenerCalendarios()
    return self.repositoriocalendarios.obtenerCalendarios()
  end
  
  def eliminarCalendario(nombreCalendario)
    self.repositoriocalendarios.eliminarCalendario(nombreCalendario)
    self.persistidorDeDatos.eliminarCalendario(nombreCalendario)
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
      validadorDeJson.validar_parametros_evento(parametrosCalendario)
      nombreCalendario = parametrosEvento[:calendario]
      validadorCalendario.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      nombreEvento = parametrosEvento[:nombre].downcase
      inicio = parametrosEvento[:inicio]
      fin = parametrosEvento[:fin]
      validadorEvento.validarExisteEvento(nombreEvento,calendario)
      validadorEvento.validarDuracionEvento(nuevoInicio, nuevoFin)
      calendario.crearEvento(nombreEvento,inicio,fin)
      self.repositoriocalendarios.agregarCalendario(calendario)
      persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios);
  end
  
    def actualizarEvento(datos_json)
  
      parametrosCalendario = {
      calendario: datos_json["calendario"],
      nombre: datos_json["nombre"],
      inicio: datos_json["inicio"],
      fin: datos_json["fin"]
    } 
      validadorDeJson.validar_parametros_evento(parametrosCalendario)
      nombreCalendario = parametrosEvento[:calendario]
      validadorCalendario.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      nombreEvento = parametrosEvento[:nombre].downcase
      inicio = parametrosEvento[:inicio]
      fin = parametrosEvento[:fin]
      validadorEvento.validarNoExisteEvento(nombreEvento,calendario)
      validadorEvento.validarDuracionEvento(nuevoInicio, nuevoFin)
      calendario.actualizarEvento(nombreEvento,inicio,fin)
      self.repositoriocalendarios.agregarCalendario(calendario)
      persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios);

  end
  
  def eliminarEvento(parametrosEvento)
      validadorDeJson.validar_parametros_evento(parametrosCalendario)
      nombreCalendario = parametrosEvento[:calendario]
      validadorCalendario.existe_calendario(self.repositoriocalendarios,nombreCalendario)
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
      nombreEvento = parametrosEvento[:nombre].downcase
      validadorEvento.validarNoExisteEvento(nombreEvento,calendario)
      calendario.eliminarEvento(nombreEvento)
      self.repositoriocalendarios.agregarCalendario(calendario)
      persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios);

  end
  
  def obtenerEvento(nombreEvento)  
    eventos = obtenerDiccionarioTodosLosEventos

    return eventos[nombreEvento]
  end
  
  def obtenerEventos(nombreCalendario)
    calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario)
    return calendario.obtenerEventos
  end

  def obtenerDiccionarioTodosLosEventos()
    calendarios = self.repositoriocalendarios.obtenerCalendarios()
    eventos = {}

    calendarios.each do |calendario|
      calendario.obtenerEventos.each do |evento|
        eventos[evento.nombre] = evento
      end
    end

    return eventos
  end

  def obtenerTodosLosEventos
    return obtenerDiccionarioTodosLosEventos.values
  end

end