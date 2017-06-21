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
    identificacion = estandarizar_identificacion(calendario.nombre)
    comprobar_unicidad_calendario(identificacion)
    @calendarios[identificacion] = calendario
  end

  def obtener_calendario(nombre)
    nombre = estandarizar_identificacion(nombre)
    @calendarios[nombre] || raise(ExcepcionCalendarioInexistente)
  end

  def obtener_calendarios
    @calendarios.values
  end

  def eliminar_calendario(nombre)
    nombre = estandarizar_identificacion(nombre)
    unless @calendarios.delete(nombre)
      raise ExcepcionCalendarioInexistente
    end
  end

  private

  def estandarizar_identificacion(identificacion)
    identificacion.downcase
  end

  def comprobar_unicidad_calendario(identificacion)
    raise ExcepcionUnicidadCalendario if @calendarios.key?(identificacion)
  end
end