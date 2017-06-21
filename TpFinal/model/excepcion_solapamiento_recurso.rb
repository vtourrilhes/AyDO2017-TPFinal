# Error para cuando se encuentra ocupado un recurso
# en un intervalo solicitado
class ExcepcionSolapamientoRecurso < StandardError
  def initialize(msg = 'El recurso no se encuentra disponible en el intervalo solicitado.')
    super
  end
end