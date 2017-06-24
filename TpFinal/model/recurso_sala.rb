require_relative '../model/recurso'

class RecursoSala < Recurso

  def initialize(nombre, estado)
    @nombre = nombre
    @tipo = "sala"  
  end

  def getTipo()
    @tipo
  end

  def to_h 
    { "nombre" => @nombre, "tipo" => @tipo }
  end
end