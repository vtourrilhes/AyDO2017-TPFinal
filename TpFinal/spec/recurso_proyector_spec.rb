require 'rspec'
require 'json'
require_relative '../model/recurso_proyector'

describe 'RecursoProyector' do 
  it 'Al llamar al metodo to_h crea el hash con el estado funcional al pasarle nil' do
    recursoProy = RecursoProyector.new("proyector1", nil)

    result = JSON.generate(recursoProy.to_h)

    expect(result).to eq '{"nombre":"proyector1","tipo":"proyector","estado":"funcional"}'
  end
end