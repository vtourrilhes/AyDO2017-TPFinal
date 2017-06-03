require_relative '../model/calendario'

class GestorCalendario

  calendarios = {}

  def crearCalendario(nombreCalendario)
    calendarios[nombreCalendario] = Calendario.new(nombreCalendario)
    return calendarios[nombreCalendario]
  end

end