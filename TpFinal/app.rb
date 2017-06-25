require 'sinatra'
require 'json'
require_relative 'model/controlador'
require_relative 'model/formateador_json'

RUTA_CALENDARIOS = 'calendarios.dump'
RUTA_RECURSOS    = 'recursos.dump'

controlador = Controlador.new(
  RepositorioCalendarios.new,
  RepositorioRecursos.new,
  RepositorioFrecuencias.new,
  ValidadorUnicidadEvento.new,
  PersistidorDeDatos.new(RUTA_CALENDARIOS),
  PersistidorDeDatos.new(RUTA_RECURSOS),
  RecursosBuilder.new()
)

post '/calendarios' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    calendario = controlador.crear_calendario(datos_json)
    FormateadorJson.formatear_elemento(calendario)
  rescue  ExcepcionUnicidadCalendario,
          ExcepcionNombreCalendario
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    controlador.eliminar_calendario(nombre)
  rescue ExcepcionCalendarioInexistente
    status 404
  end
end

get '/calendarios' do
  calendarios = controlador.obtener_calendarios
  FormateadorJson.formatear_elementos(calendarios)
end

get '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    calendario = controlador.obtener_calendario(nombre)
    FormateadorJson.formatear_elemento(calendario)
  rescue ExcepcionCalendarioInexistente
    status 404
  end
end

post '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    controlador.crear_evento(datos_json)
  rescue  ExcepcionCalendarioInexistente,
          ExcepcionIntervaloErroneo,
          ExcepcionIntervaloMaximo,
          ExcepcionUnicidadEvento,
          ExcepcionSolapamientoEvento,
          ExcepcionUnicidadGlobalEvento,
          ExcepcionSolapamientoRecurso,
          ExcepcionRecursoInexistente,
          ExcepcionHorasMaximasRecurso,
          ExcepcionRecursoEstadoIncorrecto,
          ExcepcionCantidadDiasRecurso
    status 400
  end
end

put '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse request.body.read
    controlador.actualizar_evento(datos_json)
  rescue  ExcepcionCalendarioInexistente,
          ExcepcionEventoInexistente,
          ExcepcionIntervaloErroneo,
          ExcepcionIntervaloMaximo,
          ExcepcionSolapamientoEvento,
          ExcepcionSolapamientoRecurso,
          ExcepcionRecursoInexistente,
          ExcepcionHorasMaximasRecurso,
          ExcepcionRecursoEstadoIncorrecto,
          ExcepcionCantidadDiasRecurso
    status 400
  end
end

delete '/eventos/:id' do
  begin
    id_evento = params[:id]
    controlador.eliminar_evento(id_evento)
  rescue ExcepcionEventoInexistente
    status 404
  end
end

get '/eventos' do
  begin
    nombre_calendario = params[:calendario]
    eventos = nombre_calendario.nil? ? controlador.obtener_todos_los_eventos : controlador.obtener_eventos(nombre_calendario)
    FormateadorJson.formatear_elementos(eventos)
  rescue ExcepcionCalendarioInexistente
    status 400
  end
end

get '/eventos/:id' do
  begin
    id_evento = params[:id]
    evento = controlador.obtener_evento(id_evento)
    FormateadorJson.formatear_elemento(evento)
  rescue ExcepcionEventoInexistente
    status 404
  end
end

post '/recursos' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    recurso = controlador.crear_recurso(datos_json)
    FormateadorJson.formatear_elemento(recurso)
  rescue ExcepcionSolapamientoRecurso,
         ExcepcionUnicidadRecurso,
         ExcepcionFechaAsignacionRecurso,
         ExcepcionCantidadDiasRecurso,
         ExcepcionRecursoEstadoIncorrecto,
         ExcepcionHorasMaximasRecurso,
         ExcepcionRecursoInvalido
    status 400
  end
end

get '/recursos' do
  recursos = controlador.obtener_todos_los_recursos
  FormateadorJson.formatear_elementos(recursos)
end

delete '/recursos/:nombre' do
  begin
    nombre_recurso = params[:nombre]
    controlador.eliminar_recurso(nombre_recurso)
  rescue ExcepcionRecursoInexistente
    status 404
  end
end