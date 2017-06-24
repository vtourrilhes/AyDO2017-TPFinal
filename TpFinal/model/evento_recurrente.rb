require_relative '../model/evento'

# Representa un evento. Limitado por un inicio y un fin
# el cual se repite con una determinada frecuencia.
class EventoRecurrente < Evento
  attr_accessor :frecuencia
  attr_accessor :fin_recurrencia

  def to_h
    {
      'id' => @id,
      'nombre' => @nombre,
      'fecha_inicio' => @fecha_inicio,
      'fecha_fin' => @fecha_fin,
      'recurso' => @recurso,
      'frecuencia' => @frecuencia.to_h,
      'fin_recurrencia' => @fin_recurrencia
    }
  end

  def initialize(id, nombre, fecha_inicio, fecha_fin, frecuencia, fin_recurrencia)
    super(id, nombre, fecha_inicio, fecha_fin)
    validar_intervalo_recurrencia(fecha_inicio, fin_recurrencia)
    @frecuencia = frecuencia
    @fin_recurrencia = fin_recurrencia
  end

  def inicio=(value)
    validar_intervalo_recurrencia(value, @fin_recurrencia)
    super(value)
  end

  def fin_recurrencia=(value)
    validar_intervalo_recurrencia(@fecha_inicio, value)
    @fin_recurrencia = value
  end

  def fin_recurrencia
    @fin_recurrencia
  end

  def get_frecuencia 
    @frecuencia
  end

  def obtener_intervalo
    intervalos = []
    fecha_inicio = @fecha_inicio
    fecha_fin = @fecha_fin
    while fecha_inicio <= @fin_recurrencia do
      intervalos << (fecha_inicio..fecha_fin)
      fecha_inicio += @frecuencia.periodo_repeticion
      fecha_fin += @frecuencia.periodo_repeticion
    end
    intervalos
  end

  private

  def validar_intervalo_recurrencia(fecha_inicio, fin_recurrencia)
    raise ExcepcionIntervaloErroneo if fin_recurrencia < fecha_inicio
  end
end