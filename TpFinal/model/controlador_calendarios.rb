require_relative '../model/calendario'
require_relative '../model/recurrencia_evento'
require_relative '../model/repositorio_calendarios'
require_relative '../model/persistidor_de_datos'
require_relative '../model/json_calendario'
require_relative '../model/json_evento'
require_relative '../model/validador_de_json'
require_relative '../model/validador_de_calendario'
require_relative '../model/validador_de_evento'
require_relative '../model/conversor_string_a_fecha_tiempo'
require_relative '../model/frecuencia'
require 'json'

class ControladorCalendarios

  attr_accessor :repositorio_calendarios
  attr_accessor :persistidor_de_datos
  attr_accessor :validador_json
  attr_accessor :validador_calendario
  attr_accessor :validador_evento
  attr_accessor :frecuencias

  def initialize
    inicializar_frecuencias
    @repositorio_calendarios = RepositorioCalendarios.new
    @persistidor_de_datos = PersistidorDeDatos.new
    @persistidor_de_datos.cargar_repositorio(@repositorio_calendarios)
    @validador_calendario = ValidadorDeCalendario.new
    @validador_evento = ValidadorDeEvento.new
    @validador_json = ValidadorDeJSON.new
  end

  def crear_calendario(datos_json)
    json_calendario = JsonCalendario.new(datos_json)
    nombre_calendario = json_calendario.obtenerNombreCalendario
    @validador_calendario.existe_calendario(@repositorio_calendarios,nombre_calendario)
    calendario = @repositorio_calendarios.crear_calendario(nombre_calendario)
    @persistidor_de_datos.guardar_repositorio(@repositorio_calendarios)
    calendario
  end

  def obtener_calendario(nombre)
    @repositorio_calendarios.obtener_calendario(nombre)
  end

  def obtener_calendarios
    @repositorio_calendarios.obtener_calendarios
  end

  def eliminar_calendario(nombre)
    @repositorio_calendarios.eliminar_calendario(nombre)
    @persistidor_de_datos.eliminar_calendario(nombre)
  end

  def crear_evento(datos_json)
    @validador_json.validar_parametros_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    nombre_calendario = json_evento.obtenerNombreCalendario.downcase

    @validador_calendario.no_existe_calendario(@repositorio_calendarios,nombre_calendario)
    calendario = @repositorio_calendarios.obtener_calendario(nombre_calendario)
    id_evento = json_evento.obtenerIdEvento.downcase
    inicio = convertir_string_a_time(json_evento.obtenerFechaInicio)
    fin = convertir_string_a_time(json_evento.obtenerFechaFin)
    @validador_evento.validar_existe_evento(id_evento.downcase, calendario)
    @validador_evento.validar_duracion_evento(inicio, fin)
    calendario.crear_evento(id_evento, json_evento.obtenerNombreEvento, inicio, fin)
    if json_evento.tieneRecurrencia?
      frecuencia = json_evento.obtenerFrecuenciaDeRecurrencia
      frecuencia = @frecuencias[frecuencia]
      fin_recurrencia = convertir_string_a_time(json_evento.obtenerFinDeRecurrencia)
      recurrencia = Recurrencia.new(fin_recurrencia,frecuencia)
      calendario.crear_evento_recurrente(id_evento, recurrencia)
    end
    @repositorio_calendarios.agregar_calendario(calendario)
    @persistidor_de_datos.guardar_repositorio(@repositorio_calendarios)
  end

  def actualizar_evento(datos_json)
    @validador_json.validar_parametros_actualizacion_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    id_calendario = json_evento.obtenerNombreCalendario.downcase
    inicio = json_evento.obtenerFechaInicio
    fin = json_evento.obtenerFechaFin
    @validador_calendario.no_existe_calendario(@repositorio_calendarios, id_calendario)
    calendario = @repositorio_calendarios.obtener_calendario(id_calendario)
    evento = calendario.obtener_evento(json_evento.obtenerIdEvento.downcase)
    @validador_evento.validar_actualizacion_evento(evento)
    actualizar = !(inicio.nil?) || !(fin.nil?)
    if actualizar
      inicio = asignar_fecha(inicio, evento)
      fin = asignar_fecha(fin, evento)
      @validador_evento.validar_duracion_evento(inicio, fin)
      evento.actualizar_evento(inicio, fin)
      @persistidor_de_datos.guardar_repositorio(@repositorio_calendarios)
    end
    actualizar
  end

  def asignar_fecha(fecha_string, evento)
    fecha = evento.fecha_inicio
    unless fecha_string.nil?
      fecha = convertir_string_a_time(fecha_string)
    end
    fecha
  end

  def eliminar_evento(id_calendario, id_evento)
    @validador_calendario.no_existe_calendario(@repositorio_calendarios,id_calendario)
    calendario = @repositorio_calendarios.obtener_calendario(id_calendario)
    @validador_evento.validar_no_existe_evento(id_evento, calendario)
    calendario.eliminar_evento(id_evento)
    @persistidor_de_datos.guardar_repositorio(@repositorio_calendarios)
  end

  def obtener_evento(id)
    eventos = obtener_todos_los_eventos
    eventos.select{|evento| evento.id == id}
  end

  def obtener_eventos(nombre_calendario)
    eventos = obtener_todos_los_eventos
    unless nombre_calendario.nil?
      @validador_calendario.no_existe_calendario(@repositorio_calendarios, nombre_calendario)
      calendario = @repositorio_calendarios.obtener_calendario(nombre_calendario)
      eventos = calendario.obtener_eventos
    end
    eventos
  end

  def obtener_todos_los_eventos
    calendarios = @repositorio_calendarios.obtener_calendarios
    eventos = []
    contador = 0
    calendarios.each do |calendario|
      calendario.obtener_eventos.each do |evento|
        eventos[contador] = evento
        contador = contador + 1
      end
    end
    eventos
  end

  private

  def inicializar_frecuencias
    @frecuencias = {}
    @frecuencias['diaria'] = Frecuencia.new('diaria',1)
    @frecuencias['semanal'] = Frecuencia.new('semanal',7)
    @frecuencias['quincenal'] = Frecuencia.new('quincenal',15)
    @frecuencias['mensual'] = Frecuencia.new('mensual',30)
  end
end