require_relative 'json_evento'
require 'json'

class ValidadorDeJSON
  def validar_parametros_calendario(params)
    raise TypeError unless params.is_a? Hash
    raise TypeError unless params[:nombre].is_a? String
  end
  
  def validar_parametros_actualizacion_evento(params)
    json = JsonEvento.new(params)
    raise TypeError.new('No se especifico el id del evento') if json.obtener_id_evento.nil?
    raise TypeError.new('No se especifico el calendario del evento') if json.obtener_nombre_calendario.nil?
    
  end

  def validar_parametros_evento(params)
    json = JsonEvento.new(params)
    raise TypeError.new('No se especifico el id del evento') if json.obtener_id_evento.nil?
    raise TypeError.new('No se especifico el id del calendario') if json.obtener_nombre_calendario.nil?
    raise TypeError.new('No se especifico el nombre del evento') if json.obtener_nombre_evento.nil?
    raise TypeError.new('No se especifico el fecha inicio del evento') if json.obtener_fecha_inicio.nil?
    raise TypeError.new('No se especifico el fecha fin del evento') if json.obtener_fecha_fin.nil?
  end
end