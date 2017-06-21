require 'rspec'
require_relative '../model/repositorio_recursos'

describe 'Repositorio Recursos' do
  it 'Debe poder almacenar un recurso' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    repositorio.agregar_recurso(recurso)
  end

  it 'Debe poder almacenar varios recursos' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    otro_recurso = double('Recurso 2')
    allow(otro_recurso).to receive(:nombre).and_return('Recurso 2')
    repositorio = RepositorioRecursos.new
    repositorio.agregar_recurso(recurso)
    repositorio.agregar_recurso(otro_recurso)
  end

  # En este caso la identificacion es la misma
  # y los nombres de calendario son iguales
  it 'Error al almacenar un recurso con una identificacion ya almacenada' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    otro_recurso = double('Recurso 1')
    allow(otro_recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    repositorio.agregar_recurso(recurso)
    expect do
      repositorio.agregar_recurso(otro_recurso)
    end.to raise_error(ExcepcionUnicidadRecurso)
  end

  # En este caso la identificacion es la misma
  # pero los nombres de los calendarios son diferentes
  it 'Error al almacenar un recurso con una identificacion ya almacenada' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    otro_recurso = double('Recurso 1')
    allow(otro_recurso).to receive(:nombre).and_return('ReCurso 1')
    repositorio = RepositorioRecursos.new
    repositorio.agregar_recurso(recurso)
    expect do
      repositorio.agregar_recurso(otro_recurso)
    end.to raise_error(ExcepcionUnicidadRecurso)
  end

  it 'Deberia poder obtener un recurso existente' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    recurso = repositorio.agregar_recurso(recurso)
    expect(repositorio.obtener_recurso(recurso.nombre)).to eq recurso
  end

  it 'Deberia poder obtener todos los recursos existente' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    recurso = repositorio.agregar_recurso(recurso)
    expect(repositorio.obtener_recursos).to eq [recurso]
  end

  it 'Error al obtener un recurso inexistente' do
    repositorio = RepositorioRecursos.new
    expect do
      repositorio.obtener_recurso('inexistente')
    end.to raise_error(ExcepcionRecursoInexistente)
  end

  it 'Deberia poder eliminar un recurso existente' do
    recurso = double('Recurso 1')
    allow(recurso).to receive(:nombre).and_return('Recurso 1')
    repositorio = RepositorioRecursos.new
    recurso = repositorio.agregar_recurso(recurso)
    repositorio.eliminar_recurso(recurso.nombre)
  end

  it 'Error al eliminar un recurso inexistente' do
    repositorio = RepositorioRecursos.new
    expect do
      repositorio.eliminar_recurso('inexistente')
    end.to raise_error(ExcepcionRecursoInexistente)
  end
end