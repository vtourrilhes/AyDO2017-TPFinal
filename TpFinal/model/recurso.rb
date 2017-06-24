class Recurso
  attr_reader :nombre

  def to_h
    {
      'nombre' => @nombre
    }
  end

  def initialize(nombre)
    @nombre = nombre
  end

  def getNombre()
    @nombre
  end
end