require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'
require_relative '../model/controllercalendarios'
require_relative '../model/validadorDeCalendario'
require 'json'

describe 'ControllerCalendarios' do
    
    let(:controlador) { ControllerCalendarios.new}
    let(:validador) { ValidadorDeCalendario.new}
    
    it "Se crea un calendario de nombre Laboral al llamar a obtenerCalendario deberia devolver calendario de nombre laboral" do
      
      json = JSON.parse '{"nombre":"Laboral"}'
     
      nombre= json["nombre"]

      controlador.crearCalendario(json)

      calendario = controlador.obtenerCalendario(nombre)  
        
      expect(calendario.nombre).to eq nombre
    end

    it "Agregar calendario en repositorio sin calendarios deberia devolver una lista de calendario de tamanio 1" do
      
     json = JSON.parse '{"nombre":"Laboral"}'
        
     nombre= json["nombre"]

      controlador.crearCalendario(json)

      calendarios = controlador.obtenerCalendarios()
      
      expect(calendarios.values.size).to eq 1	
    end

    it "Agregar calendario de nombre Aydoo al preguntar si esta el calendario deberia devolver true" do
      
     json = JSON.parse '{"nombre":"Laboral"}'
        
     parametrosCalendario = {
      nombre: json["nombre"]
     }
        
      controlador.crearCalendario(json)
  
      expect(validador.no_existe_calendario(controlador.repositoriocalendarios,parametrosCalendario.nombre)).to eq true
      #expect{validador.no_existe_calendario(controlador.repositoriocalendarios,parametrosCalendario.nombre)}.to raise_error(NameError)
      #expect(controlador.estaCalendario?parametrosCalendario.nombre).to eq true
    end

    it "Crear calendario en repositorio vacio deberia devolver tamanio lista de calendarios en 1" do
      
      parametros = {
          nombre: "Aydoo"
      }
      
      controlador.crearCalendario(parametros)

      calendarios = controlador.obtenerCalendarios()
      
      expect(calendarios.values.size).to eq 1	
    end

    it "Si intento crear un calendario pero el formato del parametro no es JSON entonces lanzo excepcion" do
      
      expect{controlador.crearCalendario("Aydoo")}.to raise_error(TypeError)
    end
  
   it "Crear 2 calendarios con el mismo nombre deberia devolver excepcion de calendario ya existente" do
      
       parametros = {
          nombre: "Aydoo"
      }
      
      controlador.crearCalendario(parametros)

      expect{controlador.crearCalendario(parametros)}.to raise_error(NameError)
    end
  
end