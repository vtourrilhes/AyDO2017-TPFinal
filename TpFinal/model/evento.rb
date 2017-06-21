class Evento
  attr_reader :id
  attr_accessor :fecha_inicio
  attr_accessor :fecha_fin
  attr_accessor :nombre

  def to_h
    {
      'id' => @id,
      'nombre' => @nombre,
      'fecha_inicio' => @fecha_inicio,
      'fecha_fin' => @fecha_fin
    }
  end

  def initialize(id, nombre, fecha_inicio, fecha_fin)
    @id = id
    @nombre = nombre
    @fecha_inicio = fecha_inicio
    @fecha_fin = fecha_fin
  end

  def actualizar_evento(fecha_inicio, fecha_fin)
    @fecha_inicio = fecha_inicio
    @fecha_fin = fecha_fin
  end

  def obtener_intervalo
    @fecha_inicio..@fecha_fin
  end
end