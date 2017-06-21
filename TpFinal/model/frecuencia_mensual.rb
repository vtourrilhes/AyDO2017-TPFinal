# Tipo de frecuencia mensual
class FrecuenciaMensual
  attr_reader :periodo_repeticion

  def initialize
    @periodo_repeticion = 30
  end

  def to_h
    {
      'periodo_repeticion' => @periodo_repeticion
    }
  end
end