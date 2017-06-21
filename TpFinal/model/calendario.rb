require_relative '../model/excepcion_nombre_calendario'
require_relative '../model/evento'
require_relative '../model/generador_de_recurrencia'

NOMBRE_VACIO = ''.freeze

# Clase que funciona como controlador y repositorio de Eventos.
class Calendario
  attr_accessor :eventos
  attr_reader :nombre

  def to_h
    {
      'nombre' => @nombre
    }
  end

  def initialize(nombre)
    validar_nombre(nombre)
    @nombre = nombre
    @eventos = {}
  end

  def agrega_evento(evento)
    @eventos[evento.id] = evento
  end

  def obtener_evento(id)
    @eventos[id]
  end

  def actualizar_evento(id, fecha_inicio, fecha_fin)
    evento = obtener_evento(id)
    evento.actualizar_evento(fecha_inicio, fecha_fin)
    agrega_evento(evento)
  end

  def obtener_eventos
    @eventos.values
  end

  def esta_evento?(id)
    @eventos.key?(id)
  end

  def eliminar_evento(id)
    @eventos.delete(id)
  end

  private

  def validar_nombre(nombre)
    raise ExcepcionNombreCalendario if nombre == NOMBRE_VACIO
  end
end