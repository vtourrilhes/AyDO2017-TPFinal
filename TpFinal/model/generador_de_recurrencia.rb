require_relative '../model/evento'
require_relative '../model/recurrencia'

class GeneradorDeRecurrencia

  attr_accessor :eventos

  def crear_eventos_recurrentes(calendario, evento, recurrencia)

    @eventos = {}
    tiempo_evento = evento.fecha_fin - evento.fecha_inicio
    recurrencia = recurrencia
    frecuencia = recurrencia.frecuencia.periodo_repeticion
    fecha_fin = recurrencia.fecha_fin
    fecha_inicio = evento.fecha_inicio
    fecha_inicio = fecha_inicio + frecuencia
    index = 1

    while fecha_inicio <= fecha_fin do
      evento_id = evento.id + index.to_s
      fecha_fin_evento_nuevo = fecha_inicio + tiempo_evento
      evento = Evento.new(evento_id, evento.nombre, fecha_inicio, fecha_fin_evento_nuevo)
      @eventos[evento_id] = evento
      fecha_inicio = fecha_inicio + frecuencia
      index = index + 1
    end
    @eventos.values
  end
end