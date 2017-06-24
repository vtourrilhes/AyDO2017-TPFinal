require_relative '../model/recurso'

class RecursoProyector < Recurso

  def initialize(nombre, estado)
    @nombre = nombre
    @estado = inicializarEstado(estado)
    @tipo = "proyector"
  end

  def getTipo()
    @tipo
  end

  def getEstado()
    @estado
  end

  def to_h 
    { "nombre" => @nombre, "tipo" => @tipo, "estado" => @estado }
  end

  private 

  def inicializarEstado(estado)
    if(estado.nil?) 
      "funcional"
    else
      estado
    end
  end
end