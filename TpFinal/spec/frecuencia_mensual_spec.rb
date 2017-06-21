require 'rspec'
require_relative '../model/frecuencia_mensual'

describe 'Frecuencia Mensual' do
  it 'deberia devolver 30 al pedirle la frecuencia' do
    expect(FrecuenciaMensual.new.periodo_repeticion).to eq 30
  end
end