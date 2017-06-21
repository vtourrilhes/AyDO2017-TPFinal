require 'rspec'
require_relative '../model/calendario'
require_relative '../model/repositorio_calendarios'
require_relative '../model/controlador_calendarios'
require_relative '../model/validador_de_calendario'
require_relative '../model/persistidor_de_datos'
require 'json'

describe 'ControllerCalendarios' do

  let(:controlador) {ControladorCalendarios.new}
  let(:validador) {ValidadorDeCalendario.new}

  before do
    persistidor = controlador.persistidor_de_datos
    persistidor.stub(:guardar_elemento => 'calendario guardado')
    controlador.repositorio = RepositorioCalendarios.new
  end

  it 'Se crea un calendario de nombre Laboral al llamar a obtenerCalendario deberia devolver calendario de nombre laboral' do
    json = JSON.parse '{"nombre":"Laboral"}'
    nombre= json['nombre'].downcase
    controlador.crear_calendario(json)
    calendario = controlador.repositorio.obtener_calendario(nombre)
    expect(calendario.nombre).to eq nombre
  end

  it 'Agregar calendario en repositorio sin calendarios deberia devolver una lista de calendario de tamanio 1' do
    json = JSON.parse '{"nombre":"Laboral"}'
    controlador.crear_calendario(json)
    calendarios = controlador.repositorio.obtener_calendarios
    expect(calendarios.size).to eq 1
  end

  it 'Agregar calendario de nombre Aydoo al preguntar si esta el calendario deberia devolver true' do
    json = JSON.parse '{"nombre":"Laboral"}'
    nombre= json['nombre'].downcase
    controlador.crear_calendario(json)
    expect(controlador.repositorio.esta_calendario? nombre).to eq true
  end

  it 'Crear calendario en repositorio vacio deberia devolver tamanio lista de calendarios en 1' do
    json = JSON.parse '{"nombre":"Laboral"}'
    controlador.crear_calendario(json)
    calendarios = controlador.repositorio.obtener_calendarios
    expect(calendarios.size).to eq 1
  end

  it 'Crear 2 calendarios con el mismo nombre deberia devolver excepcion de calendario ya existente' do
    json = JSON.parse '{"nombre":"Laboral"}'
    controlador.crear_calendario(json)
    expect {controlador.crear_calendario(json)}.to raise_error(NameError)
  end

  it 'Se crea un calendario y un evento con recurrencia' do
    json = JSON.parse '{"nombre":"Laboral"}'
    nombre= json['nombre'].downcase
    controlador.crear_calendario(json)
    calendario = controlador.repositorio.obtener_calendario(nombre)
    expect(calendario.nombre).to eq nombre
    json = JSON.parse '{ "calendario":"Laboral",  "id":"unico-global",  "nombre":"aydoo",  "inicio": "2017-01-20T09:00:00",  "fin": "2017-01-20T12:00:00",  "recurrencia": {    "frecuencia": "diaria",    "fin":"2017-01-25"  }}'
    controlador.crear_evento(json)
    calendario = controlador.obtener_calendario(nombre)
    result = calendario.obtener_eventos
    expect(result.size).to eq 5
  end
end