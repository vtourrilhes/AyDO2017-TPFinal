require_relative '../model/calendario'

class RepositorioCalendarios

  attr_accessor :calendarios

  def initialize
    @calendarios = {}
  end

  def agregar_calendario(calendario)
    @calendarios[calendario.nombre] = calendario
  end

  def crear_calendario(nombre)
    calendario = Calendario.new(nombre)
    agregar_calendario(calendario)
    @calendarios[nombre]
  end

  def obtener_calendario(nombre)
    @calendarios[nombre]
  end

  def obtener_calendarios
    @calendarios.values
  end

  def esta_calendario?(id)
    @calendarios.key?(id)
  end

  def eliminar_calendario(nombre)
    @calendarios.delete(nombre)
  end
end