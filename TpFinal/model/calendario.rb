require_relative '../model/evento'
require_relative '../model/generarRecurrencia'

class Calendario  
 
  attr_accessor :eventos
  attr_accessor :nombre

  def initialize (nombre)  
    self.nombre = nombre 
    self.eventos = {}
  end   

  def agregarEvento(nuevoEvento)   	
  	self.eventos[nuevoEvento.id] = nuevoEvento
  end

  def obtenerEvento(id_evento)
  	return self.eventos[id_evento]
  end
  
  def actualizarEvento (id_evento,nuevoInicio, nuevoFin)
    evento = obtenerEvento(id_evento)
    evento.actualizarEvento(nuevoInicio, nuevoFin)
    agregarEvento(evento)
  end
  
  def obtenerEventos()
  	return self.eventos.values
  end

  def estaEvento?(id_evento)
  	return self.eventos.key? id_evento
  end

  def crearEvento(id_evento,nombreEvento, nuevoInicio, nuevoFin)
      id_evento = id_evento.downcase        
      nombreEvento = nombreEvento.downcase      
      evento = Evento.new(id_evento,nombreEvento, nuevoInicio, nuevoFin, self)
      agregarEvento(evento); 
  end
  
  def crearEventoRecurrente(idEvento,recurrencia)
     
     eventoNuevo = obtenerEvento? idEvento
     
     generadorDeRecurrencia = GenerarRecurrencia.new()
     
     eventosRecurrentes = generadorDeRecurrencia.crearEventosRecurrentes(self,eventoNuevo,recurrencia)
     
     #Agrego a la coleccion existente los nuevos
 		eventosRecurrentes.values.each do |eventoNuevo|
 			agregarEvento(eventoNuevo)
 		end
     
   end
  
  def eliminarEvento(nombreEvento)
    self.eventos.delete(nombreEvento)
  end
 
end