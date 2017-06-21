require 'rspec'
require_relative '../model/frecuencia_anual'

describe 'Frecuencia Anual' do
  it 'deberia devolver 365 al pedirle la frecuencia' do
    expect(FrecuenciaAnual.new.periodo_repeticion).to eq 365
  end
end