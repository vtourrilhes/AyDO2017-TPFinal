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
  rescue Exception
    status 400
  end
end

delete '/calendarios/:nombre' do
  begin
    nombre = params[:nombre]
    controlador.eliminar_calendario(nombre)
  rescue Exception
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
  rescue Exception
    status 404
  end
end

post '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse(request.body.read)
    controlador.crear_evento(datos_json)
  rescue Exception
    status 400
  end
end

put '/eventos' do
  begin
    request.body.rewind
    datos_json = JSON.parse request.body.read
    controlador.actualizar_evento(datos_json)
  rescue Exception
    status 404
  end
end

delete '/eventos/:id_calendario/:id' do
  begin
    id_calendario = params[:id_calendario]
    id_evento = params[:id]
    controlador.eliminar_evento(id_calendario, id_evento)
  rescue Exception
    status 404
  end
end

get '/eventos' do
  begin
    id_calendario = params[:calendario]
    eventos = controlador.obtener_eventos(id_calendario)
    FormateadorJson.formatear_elementos(eventos)
  rescue Exception
    status 400
  end
end

get '/eventos/:id' do
  begin
    id_evento = params[:id]
    evento = controlador.obtener_evento(id_evento.downcase)
    FormateadorJson.formatear_elemento(evento)
  rescue Exception
    status 404
  end
end