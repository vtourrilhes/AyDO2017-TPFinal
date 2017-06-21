require 'rspec'
require_relative '../model/calendario'
require_relative '../model/evento'
require_relative '../model/validador_de_evento'

describe 'Calendario' do
  let(:calendario) { Calendario.new('Laboral') }
  let(:validador) { ValidadorDeEvento.new }

  it 'Se deberia crear a partir de un nombre' do
    nombre_calendario = 'Calendario 1'
    Calendario.new(nombre_calendario)
  end

  it 'Deberia guardar el nombre con el cual se crea' do
    nombre_calendario = 'Calendario 1'
    calendario = Calendario.new(nombre_calendario)
    expect(calendario.nombre).to eq nombre_calendario
  end

  it 'Error al crear un calendario sin nombre' do
    expect do
      Calendario.new('')
    end.to raise_error(ExcepcionNombreCalendario)
  end

  it 'Error al editar nombre' do
    nombre_calendario = 'Nombre Calendario'
    nuevo_nombre_calendario = 'Nuevo Nombre'
    calendario = Calendario.new(nombre_calendario)
    expect {calendario.nombre = nuevo_nombre_calendario}.to raise_error
  end

  it 'Si creo un calendario de nombre Laboral tengo que obtenerlo' do
    expect(calendario.nombre).to eq 'Laboral'
  end

  it 'agregar 1 evento a calendario sin eventos deberia devolver cantidad de eventos = 1 ' do
    evento = Evento.new('aydo01', 'AyDoo', Time.now, Time.now)
    calendario.agrega_evento(evento)
    expect(calendario.eventos.size).to eq 1
  end

  it 'obtenerEvento de nombre AyDOO de calendario deberia devolver el evento ' do
    nombre = 'AyDOO'.downcase
    evento = Evento.new('aydo', nombre, Time.now, Time.now)
    calendario.agrega_evento(evento)
    expect(calendario.obtener_evento('aydo')).to eq evento
  end
  
  it 'validar que duracion del evento a crear sea menor o igual 72 horas' do
    inicio = Time.parse('2017-06-06 22:49')
    fin = Time.parse('2017-06-09 22:49')
    expect(validador.validar_duracion_evento(inicio, fin)).to eq true
  end

  it 'crear evento con duracion mayor a 72 horas deberia devolver excepcion de exceso de duracion' do
    inicio = Time.parse('2017-06-06 22:49')
    fin = Time.parse('2017-06-10 22:49')
    expect {validador.validar_duracion_evento(inicio, fin)}.to raise_error(NameError)
  end
end