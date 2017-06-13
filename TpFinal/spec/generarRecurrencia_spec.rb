require 'rspec' 
require_relative '../model/evento'
require_relative '../model/calendario'
require_relative '../model/recurrenciaEvento'
require_relative '../model/generarRecurrencia'
require_relative '../model/validadorDeEvento'

require 'json'

describe 'ControllerCalendarios' do

  let(:generador) { GenerarRecurrencia.new}
  let(:validador) {ValidadorDeEvento.new}
  let (:calendario) {Calendario.new("Laboral")}
  let(:evento1) { Evento.new("aydo01","Aydoo",Time.new("2017", "01","19","01","00"), Time.new("2017", "01","19","23","30"),  calendario) } 
  let(:evento2) { Evento.new("aydo02","Aydoo",Time.new("2017", "01","19","11","00"), Time.new("2017", "01","19","13","00"),  calendario) } 
  let(:evento3) { Evento.new("aydo03","Aydoo",Time.new("2017", "01","19","09","00"), Time.new("2017", "01","19","12","00"),  calendario) } 
  let(:evento4) { Evento.new("aydo04","Aydoo",Time.new("2017", "01","19","12","30"), Time.new("2017", "01","19","15","30"),  calendario) } 
  
   it "Si valido entre evento aydo03 y aydo04 obtengo true" do

    result = validador.validarEvento(evento3,evento4)  

    expect(result).to eq true
  end
  
   it "Si valido entre evento aydo01 y aydo02 obtengo exception" do

    expect{validador.validarEvento(evento1,evento2)}.to raise_error(NameError)
  end
  
  it "Si valido entre evento aydo02 y aydo03 obtengo exception" do

    expect{validador.validarEvento(evento3,evento2)}.to raise_error(NameError)
  end
  
    it "Si valido entre evento aydo02 y aydo04 obtengo exception" do

    expect{validador.validarEvento(evento4,evento2)}.to raise_error(NameError)
  end
  
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