require_relative '../model/calendario'
require_relative '../model/recurrenciaEvento'
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
  attr_accessor :frecuencias

  def initialize()  
    self.repositoriocalendarios = RepositorioCalendarios.new    
    self.persistidorDeDatos = PersistidorDeDatos.new
    self.validadorCalendario = ValidadorDeCalendario.new
    self.validadorEvento = ValidadorDeEvento.new
    self.validadorDeJson = ValidadorDeJSON.new

    self.persistidorDeDatos.cargarDatosCalendarios(self.repositoriocalendarios) 
    
    self.frecuencias = {}
    self.frecuencias['diaria'] = Frecuencia.new('diaria',1)
    self.frecuencias['semanal'] = Frecuencia.new('semanal',1)
    self.frecuencias['quincenal'] = Frecuencia.new('quincenal',1)
    self.frecuencias['mensual'] = Frecuencia.new('mensual',1)
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
      validadorDeJson.validar_parametros_evento(datos_json)
    
      datos_recurrencia = datos_json['recurrencia']      
      nombreCalendario = datos_json['calendario']      
    
      validadorCalendario.no_existe_calendario(self.repositoriocalendarios,nombreCalendario.downcase)
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario.downcase)
    
      idEvento = datos_json['id']
      nombreEvento = datos_json['nombre']
      inicio = Time.parse(datos_json['inicio'])
      fin = Time.parse(datos_json['fin'])
      
      validadorEvento.validarExisteEvento(idEvento.downcase,calendario)
      validadorEvento.validarDuracionEvento(inicio, fin)
      
      calendario.crearEvento(idEvento,nombreEvento,inicio,fin)
    
    if !datos_recurrencia.nil
    
      frecuencia = datos_recurrencia["frecuencia"]
      frecuencia_fin =  Time.parse(datos_recurrencia["fin"])
    
      frecuencia = self.frecuencias[frecuencia]
      recurrencia = Recurrencia.new(frecuencia_fin,frecuencia)
    
      calendario.crearEventoRecurrente(idEvento,recurrencia)
    end 
    
      self.repositoriocalendarios.agregarCalendario(calendario)
      persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios)
  end
  
=begin

  def crearEvento(datos_json)
      validadorDeJson.validar_parametros_evento(datos_json)
      datos_recurrencia = datos_json['recurrencia']      
      nombreCalendario = datos_json['calendario']      
      validadorCalendario.no_existe_calendario(self.repositoriocalendarios,nombreCalendario.downcase)
      calendario = self.repositoriocalendarios.obtenerCalendario(nombreCalendario.downcase)
      idEvento = datos_json['id']
      nombreEvento = datos_json['nombre']
      inicio = Time.parse(datos_json['inicio'])
      fin = Time.parse(datos_json['fin'])
      validadorEvento.validarExisteEvento(idEvento.downcase,calendario)
      validadorEvento.validarDuracionEvento(inicio, fin)
      
      calendario.crearEvento(idEvento,nombreEvento,inicio,fin)
      persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios)
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
      
      idEvento = parametrosEvento[:id].downcase
      nombreEvento = parametrosEvento[:nombre].downcase
      inicio = parametrosEvento[:inicio]
      fin = parametrosEvento[:fin]
    
      frecuencia = parametrosEvento[:frecuencia]
      frecuencia_fin = parametrosEvento[:frecuencia_fin]
    
      frecuencia = self.frecuencias[frecuencia]
      recurrencia = Recurrencia.new(frecuencia_fin,frecuencia)
      
      validadorEvento.validarExisteEvento(nombreEvento,calendario)
      validadorEvento.validarDuracionEvento(nuevoInicio, nuevoFin)
      
      calendario.crearEvento(idEvento,nombreEvento,inicio,fin)
      calendario.crearEventoRecurrente(idEvento,recurrencia)
    
      self.repositoriocalendarios.agregarCalendario(calendario)
      persistidorDeDatos.guardarDatosRepositorioCalendarios(self.repositoriocalendarios);
end
=end

  def actualizarEvento(datos_json)
      nombreEvento = datos_json['id']
      inicio = Time.parse(datos_json['inicio'])
      fin = Time.parse(datos_json['fin'])
      eventos = obtenerDiccionarioTodosLosEventos()

      validadorEvento.validarDuracionEvento(inicio, fin)      
      evento = eventos[nombreEvento.downcase]
      validadorEvento.validarActualizacionEvento(evento)
      
      evento.actualizarEvento(inicio,fin)
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
        eventos[evento.id] = evento
      end
    end

    return eventos
  end

  def obtenerTodosLosEventos
    return obtenerDiccionarioTodosLosEventos.values
  end

end