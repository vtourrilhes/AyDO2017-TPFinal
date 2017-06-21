require 'rspec' 
require_relative '../model/evento'
require_relative '../model/validador_de_evento'
require_relative '../model/calendario'

describe 'ValidadorDeEvento' do

  let(:validador) {ValidadorDeEvento.new}
  let(:calendario) {Calendario.new('Laboral')}
  let(:evento1) {
    Evento.new(
        'aydo01',
        'Aydoo',
        Time.new('2017', '01', '19', '01', '00'),
        Time.new('2017', '01', '19', '23', '30'),
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
  
  it 'Debe validar entre evento aydo03 y aydo04' do
    validador.validar_evento(evento3, evento4)
  end
  
  it 'Si valido entre evento aydo01 y aydo02 obtengo exception' do
    expect{validador.validar_evento(evento1, evento2)}.to raise_error(NameError)
  end
  
  it 'Si valido entre evento aydo01 y aydo02 obtengo exception' do
    expect{validador.validar_evento(evento2, evento1)}.to raise_error(NameError)
  end
  
  it 'Si valido entre evento aydo02 y aydo03 obtengo exception' do
    expect{validador.validar_evento(evento2, evento3)}.to raise_error(NameError)
  end
  
  it 'Si valido entre evento aydo02 y aydo04 obtengo exception' do
    expect{validador.validar_evento(evento2, evento4)}.to raise_error(NameError)
  end
end