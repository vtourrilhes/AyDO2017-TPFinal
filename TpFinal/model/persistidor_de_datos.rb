# Encargado de guardar y leer objetos de archivos.
class PersistidorDeDatos

  attr_accessor :ruta

  def initialize(ruta)
    @ruta = ruta
  end

  def guardar_elemento(elemento)
    archivo = File.open(@ruta, 'w')
    Marshal.dump(elemento, archivo)
    archivo.close
  end

  def cargar_elemento
    if File.file?(@ruta)
      archivo = File.open(@ruta, 'r')
      Marshal.load(archivo)
    end
  end

end