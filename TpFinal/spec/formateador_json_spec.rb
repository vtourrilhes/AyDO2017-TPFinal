require 'rspec'
require_relative '../model/formateador_json'

describe 'Formateador Json' do

  it 'Deberia devolver un texto con estilo json al formatear elemento' do
    hash = {'key' => 'value'}
    json_string = JSON.pretty_generate(hash)
    elemento = double('Elemento')
    allow(elemento).to receive(:to_h).and_return(hash)
    expect(FormateadorJson.formatear_elemento(elemento)).to eq(json_string)
  end

  it 'Deberia devolver un texto con estilo json al formatear elementos' do
    hash = {'key' => 'value'}
    hash_array = [hash, hash]
    json_string = JSON.pretty_generate(hash_array)
    elemento_1 = double('Elemento')
    allow(elemento_1).to receive(:to_h).and_return(hash)
    elemento_2 = double('Elemento')
    allow(elemento_2).to receive(:to_h).and_return(hash)
    expect(FormateadorJson.formatear_elementos([elemento_1, elemento_2])).to eq(json_string)
  end
end