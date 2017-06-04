class Calendario  
 
  attr_accessor :eventos
  attr_accessor :nombre

  def initialize (nombre)  
    self.nombre = nombre 
    self.eventos = {}
  end   

  def agregarEvento(nuevoEvento) 
  	self.eventos[nuevoEvento.nombre] = nuevoEvento
  end

  def obtenerEvento(id_evento)
  	return self.eventos[id_evento]
  end
 
end