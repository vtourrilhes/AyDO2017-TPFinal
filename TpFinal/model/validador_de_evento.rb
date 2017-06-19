require_relative '../model/calendario'
require 'date'

class ValidadorDeEvento

  def validar_duracion_evento(inicio, fin)
    result = ((fin - inicio) >= 0) && ((fin - inicio)/3600 <= 72)
    if !result
      raise NameError.new("El evento excede la duracion maxima de 72 horas")
    end
    result
  end

  def validar_fechas(inicio, fin)
    result = ((fin - inicio) > 0)
    if !result
      raise NameError.new("Fecha Final menor que Inicial")
    end
    result
  end

  def validar_frecuencia(dias)
    result = (dias > 0)
    if !result
      raise NameError.new("La frecuencia no es valida")
    end
    result
  end

  def validar_existe_evento(id_evento, calendario)
    if calendario.esta_evento? id_evento
      raise NameError.new("El evento ya existe")
    end
  end

  def validar_actualizacion_evento(evento)
    if evento.nil?
      raise NameError.new("El evento ha actualizar no existe")
    end
  end

  def validar_no_existe_evento(id_evento, calendario)
    if !(calendario.esta_evento? id_evento)
      raise NameError.new("El evento no existe")
    end
  end

  def validar_evento (evento_nuevo, evento_actual)
    result = true
    raise TypeError unless evento_nuevo.inicio.is_a? Time
    raise TypeError unless evento_nuevo.fin.is_a? Time
    raise TypeError unless evento_actual.inicio.is_a? Time
    raise TypeError unless evento_actual.fin.is_a? Time
    if (evento_nuevo.inicio > evento_actual.inicio and evento_actual.fin > evento_nuevo.inicio and evento_nuevo.fin > evento_actual.fin)
      result = false
      #CASO A
      raise NameError.new("Hay evento solapado - caso A " + evento_nuevo.inicio.to_s)
    end
    if evento_actual.inicio < evento_nuevo.inicio and evento_actual.fin > evento_nuevo.fin
      result = false
      #CASO B
      raise NameError.new("Hay evento solapado - caso B " + evento_nuevo.inicio.to_s)
    end
    if (evento_actual.inicio > evento_nuevo.inicio and evento_nuevo.fin > evento_actual.inicio and evento_actual.fin > evento_nuevo.fin)
      result = false
      #CASO C
      raise NameError.new("Hay evento solapado - caso C " + evento_nuevo.inicio.to_s)
    end
    if evento_nuevo.inicio < evento_actual.inicio and evento_nuevo.fin > evento_actual.fin
      result = false
      #CASO D
      raise NameError.new("Hay evento solapado - caso D " + evento_nuevo.inicio.to_s)
    end
    if !result
      raise NameError.new("Hay evento solapado")
    end
    result
  end

end