#Excepcion cuando se crea un recurso que no sea ni sala ni proyector

class ExcepcionRecursoInvalido < StandardError
  def initialize(msg = 'Recurso Invalido')
    super
  end
end