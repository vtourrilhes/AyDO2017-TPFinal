require 'rspec'
require 'json'
require_relative '../model/evento'
require_relative '../model/calendario'
require_relative '../model/recurrencia'
require_relative '../model/generador_de_recurrencia'

describe 'Controlador Calendarios' do

  let(:generador) { GeneradorDeRecurrencia.new }
  let(:calendario) { Calendario.new('Laboral') }
  let(:evento) {
    Evento.new(
        'aydoo',
        'Aydoo',
        DateTime.now,
        DateTime.now + 1
    )
  }

  it 'Si genero recurrencia diaria por 2 dias para aydo01 tengo que obtener 2 eventos' do
    frecuencia = FrecuenciaDiaria.new
    fecha_fin = DateTime.now + 2
    recurrencia = Recurrencia.new(fecha_fin, frecuencia)
    calendario.agregar_evento(evento)
    result = generador.crear_eventos_recurrentes(calendario, evento, recurrencia)
    expect(result.size).to eq 1
  end

  it 'Si genero recurrencia diaria por 7 dias para aydo01 tengo que obtener 7 eventos' do
    frecuencia = FrecuenciaDiaria.new
    fecha_fin = DateTime.now + 7
    recurrencia = Recurrencia.new(fecha_fin, frecuencia)
    calendario.agregar_evento(evento)
    result = generador.crear_eventos_recurrentes(calendario, evento, recurrencia)
    expect(result.size).to eq 6
  end
end