require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/repositorioCalendarios'

describe 'RespositorioCalendarios' do
    
    let(:repositorio) { RepositorioCalendarios.new}
    let(:calendario) { Calendario.new('Laboral')}

    before do
      repositorio.agregarCalendario(calendario)
    end
    
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
      calendarioLaboral = repositorio.obtenerCalendario(calendario.nombre)

      expect(calendarioLaboral.nombre).to eq calendario.nombre
    end  
  
end