require_relative '../model/evento'
require_relative '../model/evento_recurrente'
require_relative '../model/validador_unicidad_evento'
require_relative '../model/calendario'
require_relative '../model/repositorio_calendarios'
require_relative '../model/repositorio_recursos'
require_relative '../model/persistidor_de_datos'
require_relative '../model/excepcion_solapamiento_recurso'
require_relative '../model/repositorio_frecuencias'
require 'json'

class Controlador

  attr_accessor :repositorio_calendarios
  attr_accessor :repositorio_recursos
  attr_accessor :persistidor_de_calendarios
  attr_accessor :persistidor_de_recursos
  attr_accessor :frecuencias
  attr_accessor :validador_unicidad_eventos

  def initialize(repositorio_calendarios, repositorio_recursos, repositorio_frecuencias, validador_unicidad_eventos, persistidor_de_calendarios, persistidor_de_recursos)
    @persistidor_de_calendarios = persistidor_de_calendarios
    @persistidor_de_recursos = persistidor_de_recursos
    @frecuencias = repositorio_frecuencias.frecuencias
    @validador_unicidad_eventos = validador_unicidad_eventos
    @repositorio_calendarios = @persistidor_de_calendarios.cargar_elemento || repositorio_calendarios
    @repositorio_recursos = @persistidor_de_recursos.cargar_elemento || repositorio_recursos
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
    nombre_calendario = datos_json['calendario']
    calendario = @repositorio_calendarios.obtener_calendario(nombre_calendario)
    id_evento = datos_json['id'].downcase
    inicio = DateTime.parse(datos_json['inicio'])
    fin = DateTime.parse(datos_json['fin'])
    id_evento = id_evento.downcase
    nombre = datos_json['nombre']
    recurso = datos_json['recurso']
    recurrencia = datos_json['recurrencia']

    if !recurrencia.nil?

      frecuencia = @frecuencias[datos_json['recurrencia']['frecuencia']]
      fin_recurrencia = DateTime.parse(datos_json['recurrencia']['fin'])
      evento = EventoRecurrente.new(id_evento, nombre, inicio, fin, frecuencia, fin_recurrencia)
      asignar_recurso(recurso, evento)
    else
      evento = Evento.new(id_evento, nombre, inicio, fin)
      asignar_recurso(recurso, evento)
    end
    @validador_unicidad_eventos.validar(@repositorio_calendarios, evento.id)
    calendario.agregar_evento(evento)
    @persistidor_de_calendarios.guardar_elemento(@repositorio_calendarios)
  end

  def actualizar_evento(datos_json)
    id_evento = datos_json['id'].downcase
    fecha_inicio = datos_json['inicio']
    fecha_fin = datos_json['fin']
    recurso = datos_json['recurso']
    repositorio_evento = nil
    @repositorio_calendarios.obtener_calendarios.each do |calendario|
      repositorio_evento = calendario if calendario.eventos.key?(id_evento)
      repositorio_evento && break
    end
    raise ExcepcionEventoInexistente unless repositorio_evento
    evento = repositorio_evento.obtener_evento(id_evento)
    actualizar = !(fecha_inicio.nil?) || !(fecha_fin.nil?)
    if actualizar
      fecha_inicio = asignar_fecha(fecha_inicio, evento)
      fecha_fin = asignar_fecha(fecha_fin, evento)
      evento.actualizar_evento(fecha_inicio, fecha_fin)
      asignar_recurso(recurso, evento) unless recurso == nil
      @persistidor_de_calendarios.guardar_elemento(@repositorio_calendarios)
    end
    actualizar
  end

  def asignar_fecha(fecha_string, evento)
    fecha = evento.fecha_inicio
    unless fecha_string.nil?
      fecha = DateTime.parse(fecha_string)
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
    recurso
  end

  def asignar_recurso(nombre_recurso, evento)
    @repositorio_calendarios.obtener_calendarios.each do |calendario|
      calendario.obtener_eventos_simultaneos(evento).each do |evento_simultaneo|
        raise(ExcepcionSolapamientoRecurso) if evento_simultaneo.recurso == nombre_recurso
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