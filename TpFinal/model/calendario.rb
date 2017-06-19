require_relative '../model/evento'
require_relative '../model/generador_de_recurrencia'

# Clase que funciona como controlador y repositorio de Eventos.
class Calendario

  attr_accessor :eventos
  attr_reader :nombre

  def initialize(nombre)
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

  def crear_evento(id, nombre, fecha_inicio, fecha_fin)
    id = id.downcase
    nombre = nombre.downcase
    evento = Evento.new(id, nombre, fecha_inicio, fecha_fin, self)
    agrega_evento(evento)
  end

  def crear_evento_recurrente(id, recurrencia)
    evento_nuevo = obtener_evento(id)
    generador_de_recurrencia = GeneradorDeRecurrencia.new
    eventos_recurrentes = generador_de_recurrencia.crear_eventos_recurrentes(self, evento_nuevo, recurrencia)
    eventos_recurrentes.each do |evento|
      agrega_evento(evento)
    end
  end

  def eliminar_evento(id)
    @eventos.delete(id)
  end

end