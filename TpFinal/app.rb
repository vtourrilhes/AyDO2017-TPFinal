require 'sinatra'
require 'json'
require_relative 'model/controllercalendarios'

controlador = ControllerCalendarios.new

post '/calendarios' do
  begin
    request.body.rewind
    datos_json = JSON.parse request.body.read
    controlador.crearCalendario(datos_json)
  rescue Exception
    status 400
  end
end

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

get '/calendarios' do
  body controlador.obtenerCalendarios()
  status 200
end

get '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    body controlador.obtenerCalendario(nombre)
    status 200
  rescue Exception
    # No encontrado
    status 404
  end
end

post '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse request.body.read
    controlador.crearEvento(datos_json)
    status 201
  rescue Exception
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
  rescue Exception
    status 400
  end
end

get '/eventos' do
  nombreCalendario = params[:calendario]
  body controlador.obtenerEventos(nombreCalendario)
  status 200
end

get '/eventos/:id' do
  id_evento = params[:id]
  body controlador.obtenerEvento
  status 200
end