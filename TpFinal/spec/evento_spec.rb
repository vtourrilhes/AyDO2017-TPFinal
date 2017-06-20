require 'rspec'
require_relative '../model/evento'
require_relative '../model/calendario'

describe 'Evento' do

  let(:evento) {
    Evento.new(
      'aydo01',
      'Aydoo',
      Time.now,
      Time.now,
      Calendario.new('TpFinal')
    )
  }

  it 'actualizar evento inicio = 2017-06-03 20:00:00' do
    fecha_inicio = Time.new('2017', '06', '03', '20', '00')
    fecha_fin = Time.new('2017', '06', '03', '21', '00')
    evento.actualizar_evento(fecha_inicio, fecha_fin)
    expect(evento.fecha_inicio).to eq fecha_inicio
    expect(evento.fecha_fin).to eq fecha_fin
  end
end