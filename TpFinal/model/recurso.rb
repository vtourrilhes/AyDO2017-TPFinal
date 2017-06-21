class Recurso

  attr_reader :nombre

  def to_h
    {
        'nombre' => @nombre
    }
  end

  def initilize(nombre)
    @nombre = nombre
  end

end