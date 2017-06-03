require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorcalendario'

describe 'GestorCalendario' do

	before do
      @gestorCalendario = GestorCalendario.new
      @calendario = @gestorCalendario.crearCalendario('Laboral')
    end

  describe "OK" do
    
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
       calendario = @gestorCalendario.obtenerCalendario('Laboral')
        expect(calendario.getNombre).to eq 'Laboral'
    end
    
   end
  
end