require_relative '../model/recurso'
require_relative '../model/excepcion_fecha_asignacion_recurso'
require_relative '../model/excepcion_cantidad_dias_recurso'

require 'date'

class RecursoSala < Recurso

  def initialize(nombre, estado)
    @nombre = nombre
    @tipo = "sala"  
  end

  def getTipo()
    @tipo
  end

  def validar_asignacion_evento(evento)
    en_horario_valido(evento)
    recurrencia_valida(evento)
  end

  def to_h 
    { "nombre" => @nombre, "tipo" => @tipo }
  end

  private 

  def en_horario_valido(evento)

    horaInicioPermitida = DateTime.strptime("T09:00:00-03:00", "T%H:%M:%S%z").to_time.hour
    horaFinPermitida = DateTime.strptime("T18:00:00-03:00", "T%H:%M:%S%z").to_time.hour

    inicio = evento.fecha_inicio
    fin = evento.fecha_fin
    horaInicioEvento = inicio.to_time.hour
    horaFinEvento = fin.to_time.hour

    if(inicio.to_date() != fin.to_date() || (horaInicioEvento < horaInicioPermitida || horaFinPermitida < horaFinEvento))
      raise ExcepcionFechaAsignacionRecurso.new()
    end
  end

  def recurrencia_valida(evento)
    finrecurrencia = evento.fin_recurrencia

    if(!finrecurrencia.nil?)
      inicioEvento = evento.fecha_inicio
      diferenciaDias = (finrecurrencia.to_date.to_time.utc.to_date - inicioEvento.to_date.to_time.utc.to_date).to_f
      periodo_repeticion = evento.get_frecuencia().periodo_repeticion

      if((diferenciaDias / periodo_repeticion) > (30.0 / periodo_repeticion))
        raise ExcepcionCantidadDiasRecurso.new()
      end
    end
  end
end