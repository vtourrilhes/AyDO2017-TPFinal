require 'rspec' 
require_relative '../model/evento'
require_relative '../model/calendario'
require_relative '../model/recurrenciaEvento'
require_relative '../model/generarRecurrencia'

require 'json'

describe 'ControllerCalendarios' do

  let(:generador) { GenerarRecurrencia.new}
  let (:calendario) {Calendario.new("Laboral")}
  let(:evento1) { Evento.new("aydo01","Aydoo",Time.now, Time.now,  calendario) } 
  let(:evento2) { Evento.new("aydo02","Aydoo",Time.now, Time.now,  calendario) } 
  let(:evento3) { Evento.new("aydo03","Aydoo",Time.now, Time.now,  calendario) } 
  let(:evento4) { Evento.new("aydo04","Aydoo",Time.now, Time.now,  calendario) } 
  
  #Time.new("2017", "06","03","21","00")
=begin
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
=end
end