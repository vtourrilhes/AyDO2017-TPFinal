require 'sinatra'
require 'json'
require_relative 'model/controllercalendarios'

controlador = ControllerCalendarios.new

post '/calendarios' do
  begin
    request.body.rewind
    datos_json = JSON.parse request.body.read
    parametros = {
      nombre: datos_json["nombre"]
    }
    controlador.crearCalendario(parametros)
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
    datos_recurrencia = JSON.parse datos_json["recurrencia"]
    parametros = {
      calendario: datos_json["calendario"]
      id: datos_json["id"]
      nombre: datos_json["nombre"]
      inicio: datos_json["inicio"]
      fin: datos_json["fin"]
      
      frecuencia: datos_recurrencia["frecuencia"]
      frecuencia_fin: datos_recurrencia["fin"]
      
    }
    controlador.crearEvento(parametros)
    status 201
  rescue Exception
    status 400
  end
end

put '/eventos' do
  request.body.rewind
  datos_json = JSON.parse request.body.read
  parametros = {
      calendario: datos_json["calendario"]
      nombre: datos_json["nombre"]
      inicio: datos_json["inicio"]
      fin: datos_json["fin"]
    }
  controlador.actualizarEvento(parametros)
  status 200
end

delete '/eventos/:id' do
  id_evento = params[:id]
  controlador.eliminarEvento(id_evento)
  status 200
  rescue Exception
    status 400
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