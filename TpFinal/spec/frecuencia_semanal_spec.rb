require 'rspec'
require_relative '../model/frecuencia_semanal'

describe 'Frecuencia Semanal' do
  it 'deberia devolver 7 al pedirle la frecuencia' do
    expect(FrecuenciaSemanal.new.periodo_repeticion).to eq 7
  end

  it 'Deberia devolver un diccionario con sus atributos si le pido to_h' do
    hash = {
        'periodo_repeticion' => 7,
    }
    expect(FrecuenciaSemanal.new.to_h).to eq(hash)
  end
end