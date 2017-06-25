require_relative '../model/recurso'
require_relative '../model/excepcion_recurso_estado_incorrecto'
require_relative '../model/excepcion_horas_maximas_recurso'

class RecursoProyector < Recurso

  def initialize(nombre, estado)
    @nombre = nombre
    @estado = inicializarEstado(estado)
    @tipo = "proyector"
  end

  def getTipo()
    @tipo
  end

  def getEstado()
    @estado
  end

  def validar_asignacion_evento(evento)
    estado_valido()
    horario_valido(evento)
  end

  def to_h 
    { "nombre" => @nombre, "tipo" => @tipo, "estado" => @estado }
  end


  private 

  def inicializarEstado(estado)
    if(estado.nil?) 
      "funcional"
    else
      estado
    end
  end

  def estado_valido()
    if(@estado != "funcional")
      raise ExcepcionRecursoEstadoIncorrecto.new()
    end
  end

  def horario_valido(evento)
    inicio = evento.fecha_inicio
    fin = evento.fecha_fin
    diferenciaEnHoras = ((fin - inicio).to_f) * 24
    
    if(diferenciaEnHoras > 4) 
      raise ExcepcionHorasMaximasRecurso.new()
    end
  end
end