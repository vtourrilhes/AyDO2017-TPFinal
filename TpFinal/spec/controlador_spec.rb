require 'rspec'
require_relative '../model/controlador'

describe 'Controlador' do

  it 'Deberia poder crearse' do
    repositorio_calendarios = double('Repositorio Calendrios')
    repositorio_recursos = double('Repositorio Recursos')
    repositorio_frecuencias = double('Repositorio Frecuencias')
    allow(repositorio_frecuencias).to receive(:frecuencias).and_return({})
    validador_unicidad_eventos = double('Validador Unicidad Eventos')
    persistidor_de_calendarios = double('Persistidor De Calendarios')
    allow(persistidor_de_calendarios).to receive(:cargar_elemento).and_return(nil)
    persistidor_de_recursos = double('Persistidor De Recursos')
    allow(persistidor_de_recursos).to receive(:cargar_elemento).and_return(nil)
    Controlador.new(
      repositorio_calendarios,
      repositorio_recursos,
      repositorio_frecuencias,
      validador_unicidad_eventos,
      persistidor_de_calendarios,
      persistidor_de_recursos
    )
  end
end