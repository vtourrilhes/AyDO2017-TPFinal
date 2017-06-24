# Error para cuando una accion solicita un evento inexistente
class ExcepcionFechaAsignacionRecurso < StandardError
  def initialize(msg = 'Las fechas del evento no permiten crear el recurso')
    super
  end
end