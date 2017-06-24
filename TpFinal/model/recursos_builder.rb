require_relative '../model/recurso_sala'
require_relative '../model/recurso_proyector'

class RecursosBuilder

  TipoRecurso = Hash[
    "proyector" => RecursoProyector,
    "sala" => RecursoSala
  ]

  def crear(recurso_json)
    nombre = estandarizar_identificacion(recurso_json["nombre"])
    tipo = estandarizar_identificacion(recurso_json["tipo"])
    tipoDeRecurso = TipoRecurso[tipo]
    estado = estandarizar_identificacion(recurso_json["estado"])

    tipoDeRecurso.new(nombre, estado)
  end

  private 
    def estandarizar_identificacion(identificacion)
      identificacion.nil? ? nil : identificacion.downcase
    end
end