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
=begin
delete '/calendarios' do
  begin
    nombre = params[:nombre]
    controlador.eliminarCalendario(nombre)
    status 200
  rescue Exception
    # No encontrado
    status 404
  end
end
=end
get '/calendarios' do
  begin
    calendarios = controlador.obtenerCalendarios()  
    body convertidorJson.obtenerArrayJsonCalendarios(calendarios).to_json
    status 200
  end
end

get '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    calendario = controlador.obtenerCalendario(nombre)
    body convertidorJson.obtenerJsonCalendario(calendario).to_json
    status 200
  rescue Exception => e
    body e.message
    status 404
  end
end
=begin
post '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse request.body.read
    controlador.crearEvento(datos_json)
    status 201
  rescue Exception => e
    body e.message
    status 400
  end
end

put '/eventos' do
  request.body.rewind
  datos_json = JSON.parse request.body.read
  controlador.actualizarEvento(datos_json)
  status 200
end

delete '/eventos/:id' do
  begin
  id_evento = params[:id]
  controlador.eliminarEvento(id_evento)
  status 200
  rescue Exception => e
    body e.message
    status 400
  end
end
=end
get '/eventos' do
  eventos = controlador.obtenerTodosLosEventos()
  body convertidorJson.obtenerArrayJsonEventos(eventos).to_json
  status 200
end

get '/eventos' do
  id_calendario = params[:calendario]
  eventos = controlador.obtenerEventos(id_calendario.downcase)
  body convertidorJson.obtenerArrayJsonEventos(eventos).to_json
  status 200
end

get '/eventos/:id' do
  id_evento = params[:id]
  evento = controlador.obtenerEvento(id_evento.downcase)
  body convertidorJson.obtenerJsonEvento(evento).to_json
  status 200
end