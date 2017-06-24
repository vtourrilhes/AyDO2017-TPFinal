class ExcepcionCantidadDiasRecurso < StandardError
  def initialize(msg = 'La cantidad de dias para hacer la reserva excede los 30 maximos')
    super
  end
end