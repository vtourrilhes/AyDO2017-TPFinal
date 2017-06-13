# Validador de JSON
require 'json'
class ValidadorDeJSON

  def validar_parametros_calendario(params)
    raise TypeError unless params.is_a? Hash
    raise TypeError unless params[:nombre].is_a? String
  end
  
  def validar_parametros_evento(params)
    raise TypeError unless params.is_a? Hash
    
    raise TypeError unless !(params.has_key? :id)
    raise TypeError unless !(params.has_key? :calendario)
    raise TypeError unless !(params.has_key? :nombre)
    raise TypeError unless !(params.has_key? :inicio)
    raise TypeError unless !(params.has_key? :fin)
    raise TypeError unless !(params.has_key? :recurrencia)
  end

end