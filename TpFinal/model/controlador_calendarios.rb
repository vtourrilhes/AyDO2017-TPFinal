require_relative '../model/calendario'
require_relative '../model/recurrencia'
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

  attr_accessor :repositorio
  attr_accessor :persistidor_de_datos
  attr_accessor :validador_json
  attr_accessor :validador_calendario
  attr_accessor :validador_evento
  attr_accessor :frecuencias

  def initialize
    inicializar_frecuencias
    @repositorio = RepositorioCalendarios.new
    @persistidor_de_datos = PersistidorDeDatos.new
    @persistidor_de_datos.cargar_repositorio(@repositorio)
    @validador_calendario = ValidadorDeCalendario.new
    @validador_evento = ValidadorDeEvento.new
    @validador_json = ValidadorDeJSON.new
  end

  def crear_calendario(datos_json)
    json_calendario = JsonCalendario.new(datos_json)
    nombre_calendario = json_calendario.obtener_nombre_calendario
    @validador_calendario.existe_calendario(@repositorio, nombre_calendario)
    calendario = @repositorio.crear_calendario(nombre_calendario)
    @persistidor_de_datos.guardar_repositorio(@repositorio)
    calendario
  end

  def obtener_calendario(nombre)
    @repositorio.obtener_calendario(nombre)
  end

  def obtener_calendarios
    @repositorio.obtener_calendarios
  end

  def eliminar_calendario(nombre)
    @repositorio.eliminar_calendario(nombre)
    @persistidor_de_datos.eliminar_calendario(nombre)
  end

  def crear_evento(datos_json)
    @validador_json.validar_parametros_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    nombre_calendario = json_evento.obtener_nombre_calendario.downcase

    @validador_calendario.no_existe_calendario(@repositorio, nombre_calendario)
    calendario = @repositorio.obtener_calendario(nombre_calendario)
    id_evento = json_evento.obtener_id_evento.downcase
    inicio = convertir_string_a_time(json_evento.obtener_fecha_inicio)
    fin = convertir_string_a_time(json_evento.obtener_fecha_fin)
    @validador_evento.validar_existe_evento(id_evento.downcase, calendario)
    @validador_evento.validar_duracion_evento(inicio, fin)
    calendario.crear_evento(id_evento, json_evento.obtener_nombre_evento, inicio, fin)
    if json_evento.tiene_recurrencia?
      frecuencia = json_evento.obtener_frecuencia_recurrencia
      frecuencia = @frecuencias[frecuencia]
      fin_recurrencia = convertir_string_a_time(json_evento.obtener_fin_de_recurrencia)
      recurrencia = Recurrencia.new(fin_recurrencia, frecuencia)
      calendario.crear_evento_recurrente(id_evento, recurrencia)
    end
    @repositorio.agregar_calendario(calendario)
    @persistidor_de_datos.guardar_repositorio(@repositorio)
  end

  def actualizar_evento(datos_json)
    @validador_json.validar_parametros_actualizacion_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    id_calendario = json_evento.obtener_nombre_calendario.downcase
    fecha_inicio = json_evento.obtener_fecha_inicio
    fecha_fin = json_evento.obtener_fecha_fin
    @validador_calendario.no_existe_calendario(@repositorio, id_calendario)
    calendario = @repositorio.obtener_calendario(id_calendario)
    evento = calendario.obtener_evento(json_evento.obtener_id_evento.downcase)
    @validador_evento.validar_actualizacion_evento(evento)
    actualizar = !(fecha_inicio.nil?) || !(fecha_fin.nil?)
    if actualizar
      fecha_inicio = asignar_fecha(fecha_inicio, evento)
      fecha_fin = asignar_fecha(fecha_fin, evento)
      @validador_evento.validar_duracion_evento(fecha_inicio, fecha_fin)
      evento.actualizar_evento(fecha_inicio, fecha_fin)
      @persistidor_de_datos.guardar_repositorio(@repositorio)
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
    @validador_calendario.no_existe_calendario(@repositorio, id_calendario)
    calendario = @repositorio.obtener_calendario(id_calendario)
    @validador_evento.validar_no_existe_evento(id_evento, calendario)
    calendario.eliminar_evento(id_evento)
    @persistidor_de_datos.guardar_repositorio(@repositorio)
  end

  def obtener_evento(id)
    eventos = obtener_todos_los_eventos
    eventos.select {|evento| evento.id == id}
  end

  def obtener_eventos(nombre_calendario)
    eventos = obtener_todos_los_eventos
    unless nombre_calendario.nil?
      @validador_calendario.no_existe_calendario(@repositorio, nombre_calendario)
      calendario = @repositorio.obtener_calendario(nombre_calendario)
      eventos = calendario.obtener_eventos
    end
    eventos
  end

  def obtener_todos_los_eventos
    calendarios = @repositorio.obtener_calendarios
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
    @frecuencias['diaria'] = Frecuencia.new('diaria', 1)
    @frecuencias['semanal'] = Frecuencia.new('semanal', 7)
    @frecuencias['quincenal'] = Frecuencia.new('quincenal', 15)
    @frecuencias['mensual'] = Frecuencia.new('mensual', 30)
  end
end