class ExcepcionRecursoEstadoIncorrecto < StandardError
  def initialize(msg = 'El estado del recurso no permite que sea asignado')
    super
  end
end