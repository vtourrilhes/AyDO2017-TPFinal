require_relative '../model/evento'
require_relative '../model/validador_unicidad_evento'
require_relative '../model/generador_de_recurrencia'
require_relative '../model/calendario'
require_relative '../model/recurrencia'
require_relative '../model/repositorio_calendarios'
require_relative '../model/repositorio_recursos'
require_relative '../model/persistidor_de_datos'
require_relative '../model/json_evento'
require_relative '../model/conversor_string_a_fecha_tiempo'
require_relative '../model/excepcion_solapamiento_recurso'
require_relative '../model/repositorio_frecuencias'
require 'json'

RUTA_CALENDARIOS = 'db.dump'
RUTA_RECURSOS    = 'recursos.dump'

class ControladorCalendarios

  attr_accessor :repositorio_calendarios
  attr_accessor :repositorio_recursos
  attr_accessor :persistidor_de_calendarios
  attr_accessor :frecuencias
  attr_accessor :validador_unicidad_eventos

  def initialize
    repositorio_frecuencias = RepositorioFrecuencias.new
    @frecuencias = repositorio_frecuencias.frecuencias
    @persistidor_de_calendarios = PersistidorDeDatos.new(RUTA_CALENDARIOS)
    @persistidor_de_recursos = PersistidorDeDatos.new(RUTA_RECURSOS)
    @repositorio_calendarios = @persistidor_de_calendarios.cargar_elemento || RepositorioCalendarios.new
    @repositorio_recursos = @persistidor_de_recursos.cargar_elemento || RepositorioRecursos.new
    @validador_unicidad_eventos = ValidadorUnicidadEvento.new
  end

  def crear_calendario(datos_json)
    nombre_calendario = datos_json['nombre']
    calendario = Calendario.new(nombre_calendario)
    @repositorio_calendarios.agregar_calendario(calendario)
    @persistidor_de_calendarios.guardar_elemento(@repositorio_calendarios)
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
  end

  def crear_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    nombre_calendario = json_evento.obtener_nombre_calendario.downcase

    calendario = @repositorio_calendarios.obtener_calendario(nombre_calendario)
    id_evento = json_evento.obtener_id_evento.downcase
    inicio = convertir_string_a_time(json_evento.obtener_fecha_inicio)
    fin = convertir_string_a_time(json_evento.obtener_fecha_fin)

    # Creacion de un evento y asociacion a calendario
    id_evento = id_evento.downcase
    nombre = json_evento.obtener_nombre_evento.downcase
    evento = Evento.new(id_evento, nombre, inicio, fin)
    @validador_unicidad_eventos.validar(@repositorio_calendarios, evento.id)
    calendario.agregar_evento(evento)

    if json_evento.tiene_recurrencia?
      frecuencia = json_evento.obtener_frecuencia_recurrencia
      frecuencia = @frecuencias[frecuencia]
      fin_recurrencia = convertir_string_a_time(json_evento.obtener_fin_de_recurrencia)
      recurrencia = Recurrencia.new(fin_recurrencia, frecuencia)

      # Creacion de eventos recurrentes.
      evento_nuevo = calendario.obtener_evento(id_evento)
      generador_de_recurrencia = GeneradorDeRecurrencia.new
      eventos_recurrentes = generador_de_recurrencia.crear_eventos_recurrentes(calendario, evento_nuevo, recurrencia)
      eventos_recurrentes.each do |evento_recurrente|
        calendario.agregar_evento(evento_recurrente)
      end

    end
    @persistidor_de_calendarios.guardar_elemento(@repositorio_calendarios)
  end

  def actualizar_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    id_calendario = json_evento.obtener_nombre_calendario.downcase
    fecha_inicio = json_evento.obtener_fecha_inicio
    fecha_fin = json_evento.obtener_fecha_fin
    calendario = @repositorio_calendarios.obtener_calendario(id_calendario)
    evento = calendario.obtener_evento(json_evento.obtener_id_evento.downcase)
    actualizar = !(fecha_inicio.nil?) || !(fecha_fin.nil?)
    if actualizar
      fecha_inicio = asignar_fecha(fecha_inicio, evento)
      fecha_fin = asignar_fecha(fecha_fin, evento)
      evento.actualizar_evento(fecha_inicio, fecha_fin)
      @persistidor_de_calendarios.guardar_elemento(@repositorio_calendarios)
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

  def eliminar_evento(id_evento)
    @repositorio_calendarios.obtener_calendarios.each do |calendario|
      calendario.eliminar_evento(id_evento)
    end
    @persistidor_de_calendarios.guardar_elemento(@repositorio_calendarios)
  end

  def obtener_evento(id)
    eventos = obtener_todos_los_eventos
    evento = eventos.select { |evento| evento.id == id }
    evento[0] || raise(ExcepcionEventoInexistente)
  end

  def obtener_eventos(nombre_calendario)
    calendario = @repositorio_calendarios.obtener_calendario(nombre_calendario)
    calendario.obtener_eventos
  end

  def obtener_todos_los_eventos
    eventos = []
    @repositorio_calendarios.obtener_calendarios.each do |calendario|
      calendario.obtener_eventos.each do |evento|
        eventos << evento
      end
    end
    eventos
  end

  def obtener_todos_los_recursos
    @repositorio_recursos.obtener_recursos
  end

  def crear_recurso(datos_json)
    nombre = datos_json['nombre'].downcase
    recurso = Recurso.new(nombre)
    @repositorio_recursos.agregar_recurso(recurso)
    @persistidor_de_recursos.guardar_elemento(@repositorio_recursos)
  end

  def asignar_recurso(nombre_recurso, evento)
    @repositorio_calendarios.obtener_calendarios.each do |calendario|
      calendario.obtener_eventos_simultaneos.each do |evento_simultaneo|
        raise(ExcepcionSolapamientoRecurso) if evento_simultaneo.recurso.nombre == nombre_recurso
      end
    end
    evento.asignar_recurso(nombre_recurso)
  end

  def eliminar_recurso(nombre_recurso)
    @repositorio_calendarios.obtener_calendarios.each do |calendario|
      calendario.obtener_eventos.each do |evento|
        evento.desasignar_recurso(nombre_recurso)
      end
    end
    @repositorio_recursos.eliminar_recurso(nombre_recurso)
    @persistidor_de_recursos.guardar_elemento(@repositorio_recursos)
  end
end