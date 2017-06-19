# Validador de JSON
require_relative 'jsonEvento'

require 'json'
class ValidadorDeJSON

  def validar_parametros_calendario(params)
    raise TypeError unless params.is_a? Hash
    raise TypeError unless params[:nombre].is_a? String
  end
  
  def validar_parametros_actualizacion_evento(params)  
    json = JsonEvento.new(params)

    raise TypeError.new("No se especifico el id del evento") unless !(json.obtenerIdEvento().nil?)
    raise TypeError.new("No se especifico el calendario del evento") unless !(json.obtenerNombreCalendario().nil?)
    
  end

  def validar_parametros_evento(params)
    json = JsonEvento.new(params)   
    
    raise TypeError.new("No se especifico el id del evento") unless !(json.obtenerIdEvento().nil?)
    raise TypeError.new("No se especifico el id del calendario") unless !(json.obtenerNombreCalendario().nil?)
    raise TypeError.new("No se especifico el nombre del evento") unless !(json.obtenerNombreEvento().nil?)
    raise TypeError.new("No se especifico el fecha inicio del evento") unless !(json.obtenerFechaInicio().nil?)
    raise TypeError.new("No se especifico el fecha fin del evento") unless !(json.obtenerFechaFin().nil?)
    
  end

end