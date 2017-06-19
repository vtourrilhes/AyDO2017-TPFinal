require 'sinatra'
require 'json'
require_relative 'model/controller_calendarios'
require_relative 'model/convertidor_json'

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

  result = controlador.actualizarEvento(datos_json)
  if result
    halt 200, "Se ha actualizado el evento con exito"
  end
  rescue Exception => ex
    halt 404, "404 Not Found: " + ex.to_s
  end
end

delete '/eventos/:id_calendario/:id' do
  begin
  id_calendario = params[:id_calendario]
  id_evento = params[:id]
  
  controlador.eliminarEvento(id_calendario, id_evento)
  halt 200, "Se ha eliminado con exito el evento"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos' do
  begin
    id_calendario = params[:calendario]
    eventos = controlador.obtenerEventos(id_calendario)    
    halt 200, convertidorJson.obtenerArrayJsonEventos(eventos).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos/:id' do
  begin
  id_evento = params[:id]
  evento = controlador.obtenerEvento(id_evento.downcase)
  halt 200, convertidorJson.obtenerArrayJsonEventos(evento).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
end
end