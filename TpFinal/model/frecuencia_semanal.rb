# Tipo de frecuencia semanal
class FrecuenciaSemanal
  attr_reader :periodo_repeticion

  def initialize
    @periodo_repeticion = 7
  end

  def to_h
    {
      'periodo_repeticion' => @periodo_repeticion
    }
  end
end