require 'sinatra'
require 'json'
require_relative 'model/controllercalendarios'
require_relative 'model/convertidorJson'

controlador = ControllerCalendarios.new
convertidorJson = ConvertidorJson.new

post '/calendarios' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    calendario = controlador.crearCalendario(datos_json)

    halt 200, "Se ha creado el calendario con exito el calendario " + calendario.nombre
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    controlador.eliminarCalendario(nombre)
    halt 200, "Se ha eliminado con exito el calendario " + nombre
  rescue Exception =>ex
    halt 400, "404 Not Found: " + ex.to_s
  end
end

get '/calendarios' do
  begin
    calendarios = controlador.obtenerCalendarios()
    halt 200, convertidorJson.obtenerArrayJsonCalendarios(calendarios).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    calendario = controlador.obtenerCalendario(nombre)
    halt 200, convertidorJson.obtenerJsonCalendario(calendario).to_json
  rescue Exception => ex
    halt 404, "404 Not Found: " + ex.to_s
  end
end

post '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    controlador.crearEvento(datos_json)

    halt 201, "Se ha creado el evento con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

put '/eventos' do
  begin
  request.body.rewind
  datos_json = JSON.parse request.body.read
  controlador.actualizarEvento(datos_json)
  halt 200, "Se ha actualizado el evento con exito"
  rescue Exception => ex
    halt 404, "404 Not Found: " + ex.to_s
  end
end

delete '/eventos/:id' do
  begin
  id_evento = params[:id]
  controlador.eliminarEvento(id_evento)
  halt 200, "Se ha eliminado el evento con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos' do
  begin
  eventos = controlador.obtenerTodosLosEventos()
  halt 200, convertidorJson.obtenerArrayJsonEventos(eventos).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos' do
  begin
  id_calendario = params[:calendario]
  eventos = controlador.obtenerEventos(id_calendario.downcase)
  halt 200, convertidorJson.obtenerArrayJsonEventos(eventos).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos/:id' do
  begin
  id_evento = params[:id]
  evento = controlador.obtenerEvento(id_evento.downcase)
  halt 200, convertidorJson.obtenerJsonEvento(evento).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
end
end