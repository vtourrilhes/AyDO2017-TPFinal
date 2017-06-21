require 'rspec'
require 'json'
require_relative '../model/evento'
require_relative '../model/calendario'
require_relative '../model/recurrencia'
require_relative '../model/generador_de_recurrencia'
require_relative '../model/validador_de_evento'

describe 'Controlador Calendarios' do

  let(:generador) {GeneradorDeRecurrencia.new}
  let(:validador) {ValidadorDeEvento.new}
  let(:calendario) {Calendario.new('Laboral')}
  let(:evento1) {
    Evento.new(
        'aydo01',
        'Aydoo',
        Time.new('2017', '01', '19', '01', '00'),
        Time.new('2017', '01', '19', '23', '30')
    )
  }
  let(:evento2) {
    Evento.new(
        'aydo02',
        'Aydoo',
        Time.new('2017', '01', '19', '11', '00'),
        Time.new('2017', '01', '19', '13', '00'),
    )
  }
  let(:evento3) {
    Evento.new(
        'aydo03',
        'Aydoo',
        Time.new('2017', '01', '19', '09', '00'),
        Time.new('2017', '01', '19', '12', '00'),
    )
  }
  let(:evento4) {
    Evento.new(
        'aydo04',
        'Aydoo',
        Time.new('2017', '01', '19', '12', '30'),
        Time.new('2017', '01', '19', '15', '30'),
    )
  }

  it 'Si genero recurrencia diaria por 2 dias para aydo01 tengo que obtener 2 eventos' do
    frecuencia = Frecuencia.new('Diaria', 1)
    fecha_fin = Time.new('2017', '01', '22', '01', '00')
    recurrencia = Recurrencia.new(fecha_fin, frecuencia)
    calendario.agrega_evento(evento4)
    result = generador.crear_eventos_recurrentes(calendario, evento4, recurrencia)
    expect(result.size).to eq 2
  end

  it 'Si genero recurrencia diaria por 7 dias para aydo01 tengo que obtener 7 eventos' do
    frecuencia = Frecuencia.new('Diaria', 1)
    fecha_fin = Time.new('2017', '01', '27', '01', '00')
    recurrencia = Recurrencia.new(fecha_fin, frecuencia)
    calendario.agrega_evento(evento4)
    result = generador.crear_eventos_recurrentes(calendario, evento4, recurrencia)
    expect(result.size).to eq 7
  end
end