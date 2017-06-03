require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorcalendario'

describe 'GestorCalendario' do

	before do
      @gestorCalendario = GestorCalendario.new
      @calendario = @gestorCalendario.crearCalendario('Laboral')
      @respuestaLaboral = @calendario.getNombre
    end

  describe "OK" do
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
        expect(@respuestaLaboral).to eq 'Laboral'
    end
    
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
        expect(@gestorCalendario.obtenerCalendario('Laboral')).to eq 'Laboral'
    end
    
   end
  
end