require 'rspec'
require_relative '../model/frecuencia_diaria'

describe 'Frecuencia Diaria' do
  it 'deberia devolver 1 al pedirle la frecuencia' do
    expect(FrecuenciaDiaria.new.periodo_repeticion).to eq 1
  end

  it 'Deberia devolver un diccionario con sus atributos si le pido to_h' do
    hash = {
        'periodo_repeticion' => 1,
    }
    expect(FrecuenciaDiaria.new.to_h).to eq(hash)
  end
end