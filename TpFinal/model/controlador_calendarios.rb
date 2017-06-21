require_relative '../model/evento'
require_relative '../model/generador_de_recurrencia'
require_relative '../model/calendario'
require_relative '../model/recurrencia'
require_relative '../model/repositorio_calendarios'
require_relative '../model/persistidor_de_datos'
require_relative '../model/json_evento'
require_relative '../model/conversor_string_a_fecha_tiempo'
require_relative '../model/frecuencia'
require 'json'

class ControladorCalendarios

  attr_accessor :repositorio
  attr_accessor :persistidor_de_datos
  attr_accessor :frecuencias

  def initialize
    inicializar_frecuencias
    @persistidor_de_datos = PersistidorDeDatos.new
    @repositorio = @persistidor_de_datos.cargar_elemento || RepositorioCalendarios.new
  end

  def crear_calendario(datos_json)
    nombre_calendario = datos_json['nombre']
    calendario = Calendario.new(nombre_calendario)
    @repositorio.agregar_calendario(calendario)
    @persistidor_de_datos.guardar_elemento(@repositorio)
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
  end

  def crear_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    nombre_calendario = json_evento.obtener_nombre_calendario.downcase

    calendario = @repositorio.obtener_calendario(nombre_calendario)
    id_evento = json_evento.obtener_id_evento.downcase
    inicio = convertir_string_a_time(json_evento.obtener_fecha_inicio)
    fin = convertir_string_a_time(json_evento.obtener_fecha_fin)

    # Creacion de un evento y asociacion a calendario
    id_evento = id_evento.downcase
    nombre = json_evento.obtener_nombre_evento.downcase
    evento = Evento.new(id_evento, nombre, inicio, fin)
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
    @persistidor_de_datos.guardar_elemento(@repositorio)
  end

  def actualizar_evento(datos_json)
    json_evento = JsonEvento.new(datos_json)
    id_calendario = json_evento.obtener_nombre_calendario.downcase
    fecha_inicio = json_evento.obtener_fecha_inicio
    fecha_fin = json_evento.obtener_fecha_fin
    calendario = @repositorio.obtener_calendario(id_calendario)
    evento = calendario.obtener_evento(json_evento.obtener_id_evento.downcase)
    actualizar = !(fecha_inicio.nil?) || !(fecha_fin.nil?)
    if actualizar
      fecha_inicio = asignar_fecha(fecha_inicio, evento)
      fecha_fin = asignar_fecha(fecha_fin, evento)
      evento.actualizar_evento(fecha_inicio, fecha_fin)
      @persistidor_de_datos.guardar_elemento(@repositorio)
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
    @repositorio.obtener_calendarios.each do |calendario|
      calendario.eliminar_evento(id_evento)
    end
    @persistidor_de_datos.guardar_elemento(@repositorio)
  end

  def obtener_evento(id)
    eventos = obtener_todos_los_eventos
    evento = eventos.select { |evento| evento.id == id }
    evento[0] || raise(ExcepcionEventoInexistente)
  end

  def obtener_eventos(nombre_calendario)
    calendario = @repositorio.obtener_calendario(nombre_calendario)
    calendario.obtener_eventos
  end

  def obtener_todos_los_eventos
    eventos = []
    @repositorio.obtener_calendarios.each do |calendario|
      calendario.obtener_eventos.each do |evento|
        eventos << evento
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