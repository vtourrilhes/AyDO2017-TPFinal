require_relative '../model/calendario'
require_relative '../model/excepcion_unicidad_calendario'
require_relative '../model/excepcion_calendario_inexistente'

# Repositorio de calendarios
class RepositorioCalendarios
  attr_accessor :calendarios

  def initialize
    @calendarios = {}
  end

  def agregar_calendario(calendario)
    identificacion = calendario.nombre
    comprobar_unicidad_calendario(identificacion)
    @calendarios[identificacion] = calendario
  end

  def crear_calendario(nombre)
    calendario = Calendario.new(nombre)
    agregar_calendario(calendario)
    @calendarios[nombre]
  end

  def obtener_calendario(nombre)
    @calendarios[nombre] || raise(ExcepcionCalendarioInexistente)
  end

  def obtener_calendarios
    @calendarios.values
  end

  def esta_calendario?(id)
    @calendarios.key?(id)
  end

  def eliminar_calendario(nombre)
    unless @calendarios.delete(nombre)
      raise ExcepcionCalendarioInexistente
    end
  end

  private

  def comprobar_unicidad_calendario(identificacion)
    raise ExcepcionUnicidadCalendario if @calendarios.key?(identificacion)
  end
end