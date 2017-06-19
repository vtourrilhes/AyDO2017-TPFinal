require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/repositorio_calendarios'

describe 'RespositorioCalendarios' do
    
    let(:repositorio) { RepositorioCalendarios.new}
    
    it "Se crea un calendario de nombre Laboral al llamar a obtenerCalendario deberia devolver calendario de nombre laboral" do
      calendarioLaboral = Calendario.new('Laboral')

      repositorio.agregar_calendario(calendarioLaboral)

      expect(repositorio.obtener_calendario(calendarioLaboral.nombre)).to eq calendarioLaboral
    end

    it "Agregar calendario en repositorio sin calendarios deberia devolver una lista de calendario de tamanio 1" do
      calendarioLaboral = Calendario.new('Laboral')

      repositorio.agregar_calendario(calendarioLaboral)

      expect(repositorio.calendarios.values.size).to eq 1	
    end

    it "Agregar calendario de nombre Aydoo al preguntar si esta el calendario deberia devolver true" do
      calendarioLaboral = Calendario.new('Aydoo')

      repositorio.agregar_calendario(calendarioLaboral)

      expect(repositorio.esta_calendario? calendarioLaboral.nombre).to eq true
    end

    it "Crear calendario en repositorio vacio deberia devolver tamanio lista de calendarios en 1" do
      repositorio.crear_calendario("Aydoo")

      expect(repositorio.calendarios.values.size).to eq 1
    end

    it "Crear 2 calendarios con el mismo nombre deberia devolver 1 calendario ya existente" do
      repositorio.crear_calendario("Aydoo")
      repositorio.crear_calendario("Aydoo")
      expect(repositorio.calendarios.values.size).to eq 1  
    end
  
end