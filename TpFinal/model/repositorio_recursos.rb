require_relative '../model/recurso'

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

  def obtener_recurso(nombre)
    nombre = estandarizar_identificacion(nombre)
    @recurso[nombre] || raise(ExcepcionRecursoInexistente)
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