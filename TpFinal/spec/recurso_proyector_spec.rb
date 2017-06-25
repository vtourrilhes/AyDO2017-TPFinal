require 'rspec'
require 'json'
require_relative '../model/recurso_proyector'
require_relative '../model/excepcion_recurso_estado_incorrecto'
require_relative '../model/excepcion_horas_maximas_recurso'

describe 'RecursoProyector' do 
  it 'Al llamar al metodo to_h crea el hash con el estado funcional al pasarle nil' do
    recursoProy = RecursoProyector.new("proyector1", nil)

    result = JSON.generate(recursoProy.to_h)

    expect(result).to eq '{"nombre":"proyector1","tipo":"proyector","estado":"funcional"}'
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento no recurrente con fechas entre las 9hs y 12hs permite asignarlo' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T09:00:01-03:00")
    fin = DateTime.strptime("2017-07-01T12:00:00-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoProy = RecursoProyector.new("proyecto1", nil)

    recursoProy.validar_asignacion_evento(evento)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento con diferencia hora mayor a 4 falla' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T09:00:01-03:00")
    fin = DateTime.strptime("2017-07-01T14:00:00-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoProy = RecursoProyector.new("proyecto1", nil)
    
    expect{recursoProy.validar_asignacion_evento(evento)}
      .to raise_error(ExcepcionHorasMaximasRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento con diferencia hora mayor a 4 falla' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T21:00:01-03:00")
    fin = DateTime.strptime("2017-07-02T02:00:00-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoProy = RecursoProyector.new("proyecto1", nil)
    
    expect{recursoProy.validar_asignacion_evento(evento)}
      .to raise_error(ExcepcionHorasMaximasRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento con diferencia hora mayor a 4 horario 00' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T22:00:01-03:00")
    fin = DateTime.strptime("2017-07-02T02:00:00-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoProy = RecursoProyector.new("proyecto1", nil)
    
    recursoProy.validar_asignacion_evento(evento)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un recurso en reparacion falla' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T09:00:01-03:00")
    fin = DateTime.strptime("2017-07-01T12:00:00-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoProy = RecursoProyector.new("proyecto1", "en reparacion")
    
    expect{recursoProy.validar_asignacion_evento(evento)}
      .to raise_error(ExcepcionRecursoEstadoIncorrecto)
  end
end