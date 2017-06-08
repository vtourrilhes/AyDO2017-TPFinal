require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/evento'

describe 'Calendario' do

	let (:calendario) {Calendario.new("Laboral")}

	it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
		expect(calendario.nombre).to eq 'Laboral'
	end

	it "agregar 1 evento a calendario sin eventos deberia devolver cantidad de eventos = 1 " do
		evento = Evento.new("AyDoo", Time.now, Time.now, calendario)

		calendario.agregarEvento(evento)

		expect(calendario.eventos.size).to eq 1		
	end

	it "obtener evento de nombre AyDOO de calendario deberia devolver el evento " do
		id_evento = "AyDOO".downcase
		evento = Evento.new(id_evento, Time.now, Time.now, calendario)

		calendario.agregarEvento(evento)		

		expect(calendario.obtenerEvento(id_evento)).to eq evento	
	end

	it "crearEvento Aydoo en calendario laboral" do
      id_evento = "Aydoo"
      evento = calendario.crearEvento(id_evento, Time.now, Time.now)

      expect(calendario.obtenerEvento(id_evento.downcase)).to eq evento
    end

    it "agregar dos eventos con mismo nombre a mismo calendario deberia lanzar una excepcion" do
      calendario.crearEvento("AyDOO", Time.now, Time.now, )      

      expect{calendario.crearEvento("AyDOO", Time.now, Time.now)}.to raise_error(NameError)
    end

end