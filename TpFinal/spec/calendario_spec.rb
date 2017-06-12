require 'rspec' 
require_relative '../model/calendario'
require_relative '../model/evento'
require_relative '../model/validadorDeEvento'

describe 'Calendario' do

	let (:calendario) {Calendario.new("Laboral")}
	let (:validador) {ValidadorDeEvento.new()}

	it "Si creo un calendario de nombre Laboral tengo que obtenerlo" do
		expect(calendario.nombre).to eq 'Laboral'
	end

	it "agregar 1 evento a calendario sin eventos deberia devolver cantidad de eventos = 1 " do
		evento = Evento.new("aydo01","AyDoo", Time.now, Time.now, calendario)

		calendario.agregarEvento(evento)

		expect(calendario.eventos.size).to eq 1		
	end

	it "obtenerEvento de nombre AyDOO de calendario deberia devolver el evento " do
		nombre = "AyDOO".downcase
		evento = Evento.new("aydo01",nombre, Time.now, Time.now, calendario)

		calendario.agregarEvento(evento)		

		expect(calendario.obtenerEvento("aydo01",)).to eq evento	
	end

	it "crearEvento Aydoo en calendario laboral" do
      nombre = "Aydoo"
      evento = calendario.crearEvento("aydo01",nombre, Time.now, Time.now)

      expect(calendario.obtenerEvento("aydo01")).to eq evento
    end

    it "agregar dos eventos con mismo nombre a mismo calendario deberia lanzar una excepcion" do
      calendario.crearEvento("aydo01","AyDOO", Time.now, Time.now)      

      expect{validador.validarExisteEvento("aydo01","AyDOO", calendario)}.to raise_error(NameError)
    end

    it "preguntar evento de nombre Aydoo a calendario deberia devolver true" do
      evento = calendario.crearEvento("aydo01","AyDOO", Time.now, Time.now)      

      expect(calendario.estaEvento? evento.id).to eq true
    end

    it "validar que duracion del evento a crear sea menor o igual 72 horas" do
      inicio = Time.parse("2017-06-06 22:49")
      fin = Time.parse("2017-06-09 22:49")      

      expect(validador.validarDuracionEvento(inicio, fin)).to eq true
    end

    it "crear evento con duracion mayor a 72 horas deberia devolver excepcion de exceso de duracion" do
      inicio = Time.parse("2017-06-06 22:49")
      fin = Time.parse("2017-06-10 22:49")      
			
      expect{validador.validarDuracionEvento(inicio, fin)}.to raise_error(NameError)
    end

end