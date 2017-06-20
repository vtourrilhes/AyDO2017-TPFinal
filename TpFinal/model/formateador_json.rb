require 'json'

# Se encarga del formateo de datos en json para impresion
class FormateadorJson
  def formatear_elemento(elemento)
    JSON.pretty_generate(elemento.to_h)
  end

  def formatear_elementos(elementos)
    array = []
    elementos.each {|elemento| array << elemento.to_h}
    JSON.pretty_generate(array)
  end
end