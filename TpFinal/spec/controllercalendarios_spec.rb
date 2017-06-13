require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'
require_relative '../model/controllercalendarios'
require_relative '../model/validadorDeCalendario'
require 'json'

describe 'ControllerCalendarios' do

  let(:controlador) { ControllerCalendarios.new}
  let(:validador) { ValidadorDeCalendario.new}

  before do
    persistidor = controlador.persistidorDeDatos    
    persistidor.stub(:guardarDatosRepositorioCalendarios => "calendario guardado")
    
    controlador.repositoriocalendarios = RepositorioCalendarios.new
  end

  it "Se crea un calendario de nombre Laboral al llamar a obtenerCalendario deberia devolver calendario de nombre laboral" do

    json = JSON.parse '{"nombre":"Laboral"}'
    nombre= json["nombre"].downcase
    controlador.crearCalendario(json)
    calendario = controlador.repositoriocalendarios.obtenerCalendario(nombre)  

    expect(calendario.nombre).to eq nombre
  end

  it "Agregar calendario en repositorio sin calendarios deberia devolver una lista de calendario de tamanio 1" do

   json = JSON.parse '{"nombre":"Laboral"}'
   nombre= json["nombre"]

   controlador.crearCalendario(json)
   calendarios = controlador.repositoriocalendarios.obtenerCalendarios()

   expect(calendarios.size).to eq 1	
  end

  it "Agregar calendario de nombre Aydoo al preguntar si esta el calendario deberia devolver true" do

   json = JSON.parse '{"nombre":"Laboral"}'
   nombre= json["nombre"].downcase

   controlador.crearCalendario(json)

   expect(controlador.repositoriocalendarios.estaCalendario?nombre).to eq true
  end

  it "Crear calendario en repositorio vacio deberia devolver tamanio lista de calendarios en 1" do

    json = JSON.parse '{"nombre":"Laboral"}'

    controlador.crearCalendario(json)
    calendarios = controlador.repositoriocalendarios.obtenerCalendarios()

    expect(calendarios.size).to eq 1	
  end

  it "Crear 2 calendarios con el mismo nombre deberia devolver excepcion de calendario ya existente" do

    json = JSON.parse '{"nombre":"Laboral"}'
    nombre= json["nombre"]

    controlador.crearCalendario(json)

    expect{controlador.crearCalendario(json)}.to raise_error(NameError)
  end
  
    it "Se crea un calendario y un evento con recurrencia" do

    json = JSON.parse '{"nombre":"Laboral"}'
    nombre= json["nombre"].downcase
    controlador.crearCalendario(json)
    calendario = controlador.repositoriocalendarios.obtenerCalendario(nombre)  

    expect(calendario.nombre).to eq nombre
      
    json = JSON.parse '{ "calendario":"Laboral",  "id":"unico-global",  "nombre":"aydoo",  "inicio": "2017-01-20T09:00:00",  "fin": "2017-01-20T12:00:00",  "recurrencia": {    "frecuencia": "diaria",    "fin":"2017-01-25"  }}'  
    controlador.crearEvento(json)
    calendario = controlador.obtenerCalendario(nombre)
      
    result = calendario.obtenerEventos()
    
    expect(result.size).to eq 7
      
  end

end