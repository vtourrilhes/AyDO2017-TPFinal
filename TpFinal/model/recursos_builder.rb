require_relative '../model/recurso_sala'
require_relative '../model/recurso_proyector'
require_relative '../model/excepcion_recurso_invalido'

class RecursosBuilder

  TipoRecurso = Hash[
    "proyector" => RecursoProyector,
    "sala" => RecursoSala
  ]

  def crear(recurso_json)

    validar_recurso_valido(recurso_json)

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

    def validar_recurso_valido recurso_json

      if(recurso_json["tipo"].nil?)
        raise ExcepcionRecursoInvalido
      end

      tipo = recurso_json["tipo"].downcase
      estado = nil;

      if(! recurso_json["estado"].nil?)
        estado = recurso_json["estado"].downcase
      end

      #valido que sea sala o proyector
      if(tipo!='sala' and tipo!='proyector')
        raise ExcepcionRecursoInvalido
      end

      #valido que, si es proyector, el estado sea valido
      if(tipo=='proyector' and (estado!='en reparacion' and estado!='funcional' and ! estado.nil?))
        raise ExcepcionRecursoInvalido
      end


    end
end