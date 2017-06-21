class JsonCalendario

  attr_accessor :datos_json

  def initialize(json)
    @datos_json = json
  end

  def obtener_nombre_calendario
    @datos_json['nombre'].downcase
  end
end