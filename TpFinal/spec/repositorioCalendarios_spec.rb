require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'

describe 'RespositorioCalendarios' do
    
    let(:repositorio) { RepositorioCalendarios.new}
    
    it "Se crea un calendario de nombre Laboral al llamar a obtenerCalendario deberia devolver calendario de nombre laboral" do
      calendarioLaboral = Calendario.new('Laboral')

      repositorio.agregarCalendario(calendarioLaboral)

      expect(repositorio.obtenerCalendario(calendarioLaboral.nombre)).to eq calendarioLaboral
    end

    it "CrearCalendario en repositorio sin calendarios deberia devolver una lista de calendario de tamanio 1" do
      calendarioLaboral = Calendario.new('Laboral')

      repositorio.agregarCalendario(calendarioLaboral)

      expect(repositorio.calendarios.values.size).to eq 1	
    end
  
end