require 'rspec' 
require_relative '../model/calendario'

describe 'Calendario' do

	let (:calendario) {Calendario.new("Laboral")}

    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
        expect(calendario.nombre).to eq 'Laboral'
    end
  
end