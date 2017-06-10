# Validador de JSON
class ValidadorDeJSON
  
  def initialize()
    
  end

  def validar_parametros_calendario(params)
    raise TypeError unless params.is_a? Hash
    raise TypeError unless params[:nombre].is_a? String
  end
  
  def validar_parametros_evento(params)
    raise TypeError unless params.is_a? Hash
    raise TypeError unless params[:nombre].is_a? String
  end

end