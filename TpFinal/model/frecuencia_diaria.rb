# Tipo de frecuencia diaria
class FrecuenciaDiaria
  attr_reader :periodo_repeticion

  def initialize
    @periodo_repeticion = 1
  end

  def to_h
    {
      'periodo_repeticion' => @periodo_repeticion
    }
  end
end