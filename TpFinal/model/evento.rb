require_relative '../model/regla_intervalo_evento'
require_relative '../model/excepcion_intervalo_erroneo'

CONVERSOR_HORAS = (1 / 24.0)

# Representa un evento. Limitado por un inicio y un fin
class Evento
  attr_reader :id
  attr_accessor :fecha_inicio
  attr_accessor :fecha_fin
  attr_accessor :nombre

  def to_h
    {
      'id' => @id,
      'nombre' => @nombre,
      'fecha_inicio' => @fecha_inicio,
      'fecha_fin' => @fecha_fin
    }
  end

  def fecha_inicio=(value)
    validar_intervalo(value, @fecha_fin)
    @fecha_inicio = value
  end

  def fecha_fin=(value)
    validar_intervalo(@fecha_inicio, value)
    @fecha_fin = value
  end

  def initialize(id, nombre, fecha_inicio, fecha_fin)
    validar_intervalo(fecha_inicio, fecha_fin)
    @id = id
    @nombre = nombre
    @fecha_inicio = fecha_inicio
    @fecha_fin = fecha_fin
  end

  def actualizar_evento(fecha_inicio, fecha_fin)
    validar_intervalo(fecha_inicio, fecha_fin)
    @fecha_inicio = fecha_inicio
    @fecha_fin = fecha_fin
  end

  def obtener_intervalo
    @fecha_inicio..@fecha_fin
  end

  private

  def validar_intervalo(inicio, fin)
    raise ExcepcionIntervaloErroneo if fin < inicio
    intervalo_en_horas = convertir_a_horas(fin - inicio)
    ReglaIntervaloEvento.validar_horas(intervalo_en_horas)
  end

  def convertir_a_horas(intervalo)
    intervalo / CONVERSOR_HORAS
  end
end