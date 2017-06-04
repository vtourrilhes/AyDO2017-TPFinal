require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/gestorcalendario'

describe 'GestorCalendario' do
    
    let(:gestorCalendario) { GestorCalendario.new}
    let(:calendario) { Calendario.new('Laboral')}

    before do
      gestorCalendario.agregarCalendario(calendario)
    end
    
    it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
      calendarioLaboral = gestorCalendario.obtenerCalendario(calendario.nombre)

      expect(calendarioLaboral.nombre).to eq calendario.nombre
    end

    it "crearEvento Aydoo en calendario laboral" do
      id_evento = "Aydoo"
      calendarioLaboral = gestorCalendario.obtenerCalendario(calendario.nombre)
      evento = gestorCalendario.crearEvento(Time.now, Time.now, id_evento, calendario.nombre)

      expect(calendarioLaboral.obtenerEvento(id_evento.downcase)).to eq evento
    end

    it "agregar dos eventos con mismo nombre a mismo calendario deberia lanzar una excepcion" do
      gestorCalendario.crearEvento(Time.now, Time.now, "AyDOO", calendario.nombre)      

      expect{gestorCalendario.crearEvento(Time.now, Time.now, "AyDOO", calendario.nombre)}.to raise_error(NameError)
    end
  
end