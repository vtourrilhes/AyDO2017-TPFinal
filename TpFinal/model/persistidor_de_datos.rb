# Encargado de guardar y leer objetos de archivos.
class PersistidorDeDatos

  attr_accessor :ruta

  def initialize(ruta, file = File, marshal = Marshal)
    @ruta = ruta
    @file = file
    @marshal = marshal
  end

  def guardar_elemento(elemento)
    archivo = @file.open(@ruta, 'w')
    @marshal.dump(elemento, archivo)
    archivo.close
  end

  def cargar_elemento
    if @file.file?(@ruta)
      archivo = @file.open(@ruta, 'r')
      @marshal.load(archivo)
    end
  end

end