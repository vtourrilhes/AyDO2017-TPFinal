class JsonEvento

  attr_accessor :datos_json

  def initialize(json)
    @datos_json = json
  end

  def obtener_id_evento
    @datos_json['id']
  end

  def obtener_fecha_inicio
    @datos_json['inicio']
  end

  def obtener_fecha_fin
    @datos_json['fin']
  end

  def obtener_nombre_evento
    @datos_json['nombre']
  end

  def obtener_nombre_calendario
    @datos_json['calendario']
  end

  def obtener_recurso
    @datos_json['recurso']
  end

  def tiene_recurrencia?
    recurrencia = obtener_recurrencia
    !recurrencia.nil?
  end

  def obtener_frecuencia_recurrencia
    obtener_recurrencia['frecuencia']
  end

  def obtener_fin_de_recurrencia
    obtener_recurrencia['fin']
  end

  private

  def obtener_recurrencia
    @datos_json['recurrencia']
  end
end