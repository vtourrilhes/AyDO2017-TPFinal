require_relative '../model/recurso'
require_relative '../model/excepcion_unicidad_recurso'
require_relative '../model/excepcion_recurso_inexistente'

# Repositorio de recursos
class RepositorioRecursos
  attr_accessor :recursos

  def initialize
    @recursos = {}
  end

  def agregar_recurso(recurso)
    identificacion = estandarizar_identificacion(recurso.nombre)
    comprobar_unicidad_recurso(identificacion)
    @recursos[identificacion] = recurso
  end

  def   obtener_recurso(nombre)
    nombre = estandarizar_identificacion(nombre)
    @recursos[nombre] || raise(ExcepcionRecursoInexistente)
  end

  def obtener_recursos
    @recursos.values
  end

  def eliminar_recurso(nombre)
    nombre = estandarizar_identificacion(nombre)
    unless @recursos.delete(nombre)
      raise ExcepcionRecursoInexistente
    end
  end

  private

  def estandarizar_identificacion(identificacion)
    identificacion.downcase
  end

  def comprobar_unicidad_recurso(identificacion)
    raise ExcepcionUnicidadRecurso if @recursos.key?(identificacion)
  end
end