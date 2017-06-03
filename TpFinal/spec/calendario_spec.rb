require 'rspec' 

describe 'Calendario' do

	before do
      @calendario = Calendario.new("Laboral")
      @respuestaLaboral = @calendario.getNombre('Laboral')
    end

  describe "OK" do
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
        expect(@respuestaLaboral).to eq 'Laboral'
      end
    end
end