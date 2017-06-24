class ExcepcionHorasMaximasRecurso < StandardError
  def initialize(msg = 'El evento excede las horas maximas permitidas para asignar el recurso')
    super
  end
end