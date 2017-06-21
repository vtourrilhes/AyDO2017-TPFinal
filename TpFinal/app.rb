require 'sinatra'
require 'json'
require_relative 'model/controlador_calendarios'
require_relative 'model/formateador_json'

controlador = ControladorCalendarios.new

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
          ExcepcionUnicidadGlobalEvento
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
          ExcepcionSolapamientoEvento
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