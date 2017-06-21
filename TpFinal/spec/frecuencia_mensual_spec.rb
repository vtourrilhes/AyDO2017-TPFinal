require 'rspec'
require_relative '../model/frecuencia_mensual'

describe 'Frecuencia Mensual' do
  it 'deberia devolver 30 al pedirle la frecuencia' do
    expect(FrecuenciaMensual.new.periodo_repeticion).to eq 30
  end

  it 'Deberia devolver un diccionario con sus atributos si le pido to_h' do
    hash = {
        'periodo_repeticion' => 30,
    }
    expect(FrecuenciaMensual.new.to_h).to eq(hash)
  end
end