require 'rspec'
require 'json'
require_relative '../model/recurso_sala'

describe 'RecursoSala' do 
  it 'Al llamar al metodo to_h crea el hash sin estado' do
    recursoSala = RecursoSala.new("sala1", nil)

    result = JSON.generate(recursoSala.to_h)

    expect(result).to eq '{"nombre":"sala1","tipo":"sala"}'
  end
end