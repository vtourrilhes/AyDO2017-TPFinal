require 'rspec'
require 'json'
require_relative '../model/recursos_builder'
require_relative '../model/recurso_sala'
require_relative '../model/recurso_proyector'

describe 'RecursosBuilder' do

  let(:builder) { RecursosBuilder.new() }
  it 'Se deberia crear un recurso tipo Sala a partir de un nombre y sin estado' do
    jsonRecurso = '{"nombre": "sala1", "tipo":"sala"}'

    recursoParse = JSON.parse(jsonRecurso)

    recurso = builder.crear(recursoParse)

    expect(recurso.class).to eq RecursoSala
    expect(recurso.getNombre()).to eq "sala1"
    expect(recurso.getTipo()).to eq "sala"
  end

  it 'Se deberia crear un recurso tipo Proyector a partir de un nombre y con estado funcional' do
    jsonRecurso = '{"nombre": "proyector1", "tipo":"proyector", "estado":"funcional"}'

    recursoParse = JSON.parse(jsonRecurso)

    recurso = builder.crear(recursoParse)

    expect(recurso.class).to eq RecursoProyector
    expect(recurso.getNombre()).to eq "proyector1"
    expect(recurso.getTipo()).to eq "proyector"
    expect(recurso.getEstado()).to eq "funcional"
  end

  it 'Se deberia crear un recurso tipo Proyector a partir de un nombre y sin estado lo crea como funcional' do
    jsonRecurso = '{"nombre": "proyector1", "tipo":"proyector"}'

    recursoParse = JSON.parse(jsonRecurso)

    recurso = builder.crear(recursoParse)

    expect(recurso.class).to eq RecursoProyector
    expect(recurso.getNombre()).to eq "proyector1"
    expect(recurso.getTipo()).to eq "proyector"
    expect(recurso.getEstado()).to eq "funcional"
  end

  it 'Se deberia crear un recurso tipo Proyector a partir de un nombre con mayuculas convirtiendolo a minuscula y sin estado lo crea como funcional' do
    jsonRecurso = '{"nombre": "proYector1", "tipo":"proyector"}'

    recursoParse = JSON.parse(jsonRecurso)

    recurso = builder.crear(recursoParse)

    expect(recurso.class).to eq RecursoProyector
    expect(recurso.getNombre()).to eq "proyector1"
    expect(recurso.getTipo()).to eq "proyector"
    expect(recurso.getEstado()).to eq "funcional"
  end

  it 'Se deberia crear un recurso tipo Proyector a partir de un tipo con mayuculas convirtiendolo a minuscula y sin estado lo crea como funcional' do
    jsonRecurso = '{"nombre": "proYector1", "tipo":"proYEctor"}'

    recursoParse = JSON.parse(jsonRecurso)

    recurso = builder.crear(recursoParse)

    expect(recurso.class).to eq RecursoProyector
    expect(recurso.getNombre()).to eq "proyector1"
    expect(recurso.getTipo()).to eq "proyector"
    expect(recurso.getEstado()).to eq "funcional"
  end

  it 'Se deberia crear un recurso tipo Proyector a partir de un nombre y con estado en reparacion lo crea como en reparacion' do
    jsonRecurso = '{"nombre": "proyector1", "tipo":"proyector", "estado": "en reparacion"}'

    recursoParse = JSON.parse(jsonRecurso)

    recurso = builder.crear(recursoParse)

    expect(recurso.class).to eq RecursoProyector
    expect(recurso.getNombre()).to eq "proyector1"
    expect(recurso.getTipo()).to eq "proyector"
    expect(recurso.getEstado()).to eq "en reparacion"
  end
end