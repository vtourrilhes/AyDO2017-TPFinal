require 'sinatra'
require 'json'
require_relative 'model/controlador_calendarios'
require_relative 'model/conversor_json'

controlador = ControladorCalendarios.new
convertidorJson = ConversorJson.new

post '/calendarios' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    calendario = controlador.crear_calendario(datos_json)
    halt 200, "Se ha creado con exito el calendario " + calendario.nombre
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    controlador.eliminar_calendario(nombre)
    halt 200, "Se ha eliminado con exito el calendario " + nombre
  rescue Exception =>ex
    halt 400, "404 Not Found: " + ex.to_s
  end
end

get '/calendarios' do
  begin
    calendarios = controlador.obtener_calendarios()
    halt 200, convertidorJson.obtener_array_json_calendarios(calendarios).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    calendario = controlador.obtener_calendario(nombre)
    halt 200, convertidorJson.obtener_json_calendario(calendario).to_json
  rescue Exception => ex
    halt 404, "404 Not Found: " + ex.to_s
  end
end

post '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    controlador.crear_evento(datos_json)
    halt 201, "Se ha creado el evento con exito"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

put '/eventos' do
  begin
  request.body.rewind
  datos_json = JSON.parse request.body.read
  result = controlador.actualizar_evento(datos_json)
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
  controlador.eliminar_evento(id_calendario, id_evento)
  halt 200, "Se ha eliminado con exito el evento"
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos' do
  begin
    id_calendario = params[:calendario]
    eventos = controlador.obtener_eventos(id_calendario)
    halt 200, convertidorJson.obtener_array_json_eventos(eventos).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/eventos/:id' do
  begin
    id_evento = params[:id]
    evento = controlador.obtener_evento(id_evento.downcase)
    halt 200, convertidorJson.obtener_array_json_eventos(evento).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

post '/recursos' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    recurso = controlador.crear_recurso(datos_json)
    halt 200, "Se ha creado con exito el recurso " + recurso.nombre
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

get '/recursos' do
  begin
    recursos = controlador.obtener_recursos
    halt 200, convertidor_json.obtener_array_json_recursos(recursos).to_json
  rescue Exception => ex
    halt 400, "400 Bad Request: " + ex.to_s
  end
end

delete '/recursos/:nombre' do
  begin
    nombre = params[:nombre]
    controlador.eliminar_recurso(nombre)
    halt 200, "Se ha eliminado con exito el recurso " + nombre
  rescue Exception =>ex
    halt 400, "404 Not Found: " + ex.to_s
  end
end