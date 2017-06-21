require 'rspec'
require_relative '../model/frecuencia_anual'

describe 'Frecuencia Anual' do
  it 'deberia devolver 365 al pedirle la frecuencia' do
    expect(FrecuenciaAnual.new.periodo_repeticion).to eq 365
  end

  it 'Deberia devolver un diccionario con sus atributos si le pido to_h' do
    hash = {
        'periodo_repeticion' => 365,
    }
    expect(FrecuenciaAnual.new.to_h).to eq(hash)
  end
end