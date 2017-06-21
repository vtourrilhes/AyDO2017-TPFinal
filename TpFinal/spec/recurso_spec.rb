require 'rspec'
require_relative '../model/recurso'

describe 'Recurso' do
  it 'Se deberia crear a partir de un nombre' do
    nombre = 'Recurso 1'
    Recurso.new(nombre)
  end

  it 'Deberia devolver un diccionario con su nombre si le pido to_h' do
    hash = {'nombre' => 'recurso'}
    expect(Recurso.new('recurso').to_h).to eq(hash)
  end
end