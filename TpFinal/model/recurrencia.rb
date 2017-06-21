class Recurrencia
  attr_accessor :fecha_fin
  attr_accessor :frecuencia

  def initialize(fecha_fin, frecuencia)
    @fecha_fin = fecha_fin
    @frecuencia = frecuencia
  end
end