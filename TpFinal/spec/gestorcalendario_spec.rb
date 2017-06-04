require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorcalendario'

describe 'GestorCalendario' do

	before do
      @gestorCalendario = GestorCalendario.new
     @gestorCalendario.crearCalendario('Laboral')
     @gestorCalendario.crearCalendario('Estudiantil')
		 @gestorCalendario.crearCalendario('Personal')
    end

  describe "OK" do
    
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
       calendario = @gestorCalendario.obtenerCalendario('Laboral')
        expect(calendario.getNombre).to eq 'Laboral'
    end
    
    it "Si creo un calendario de nombre Estudiantil lo borro" do
       calendario = @gestorCalendario.borrarCalendario('Estudiantil')
        expect(calendario.getNombre).to eq 'Estudiantil'
    end
		
		it "Si creo un calendario de nombre Laboral y Personal tengo que tener 2 elementos" do
       calendarios = @gestorCalendario.obtenerCalendarios
        expect(calendarios.length).to eq 3
    end
    
   end
  
end