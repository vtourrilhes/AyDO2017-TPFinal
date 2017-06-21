# Error para violacion de unicidad de recursos segun id
class ExcepcionUnicidadRecurso < StandardError
  def initialize(msg = 'Ya existe un recurso con ese id.')
    super
  end
end
