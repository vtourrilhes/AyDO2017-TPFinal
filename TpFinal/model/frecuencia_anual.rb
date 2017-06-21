# Tipo de frecuencia anual
class FrecuenciaAnual
  attr_reader :periodo_repeticion

  def initialize
    @periodo_repeticion = 365
  end

  def to_h
    {
      'periodo_repeticion' => @periodo_repeticion
    }
  end
end