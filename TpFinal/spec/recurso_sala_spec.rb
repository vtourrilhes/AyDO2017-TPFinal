require 'rspec'
require 'json'
require_relative '../model/recurso_sala'
require_relative '../model/excepcion_fecha_asignacion_recurso'
require_relative '../model/excepcion_cantidad_dias_recurso'
require_relative '../model/frecuencia_diaria'
require_relative '../model/frecuencia_semanal'

describe 'RecursoSala' do 
  it 'Al llamar al metodo to_h crea el hash sin estado' do
    recursoSala = RecursoSala.new("sala1", nil)

    result = JSON.generate(recursoSala.to_h)

    expect(result).to eq '{"nombre":"sala1","tipo":"sala"}'
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento no recurrente con fechas entre las 9hs y 18hs permite asignarlo' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T09:00:01-03:00")
    fin = DateTime.strptime("2017-07-01T17:59:59-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoSala = RecursoSala.new("sala1", nil)

    recursoSala.validar_asignacion_evento(evento)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento no recurrente con fechas entre las 8hs y 18hs lanza exception' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T08:00:00-03:00")
    fin = DateTime.strptime("2017-07-01T17:59:59-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoSala = RecursoSala.new("sala1", nil)

    expect{recursoSala.validar_asignacion_evento(evento)}
    .to raise_error(ExcepcionFechaAsignacionRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento no recurrente con fechas entre las 9hs y 19hs lanza exception' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T08:00:00-03:00")
    fin = DateTime.strptime("2017-07-01T18:59:59-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoSala = RecursoSala.new("sala1", nil)

    expect{recursoSala.validar_asignacion_evento(evento)}
    .to raise_error(ExcepcionFechaAsignacionRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento no recurrente con fechas entre las 9hs y 18hs de dias distintos lanza exception' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T09:00:01-03:00")
    fin = DateTime.strptime("2017-07-02T17:59:59-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoSala = RecursoSala.new("sala1", nil)

    expect{recursoSala.validar_asignacion_evento(evento)}
    .to raise_error(ExcepcionFechaAsignacionRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento no recurrente con fechas a las 9hs y 18hs pasa la validacion' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T09:00:00-03:00")
    fin = DateTime.strptime("2017-07-01T18:00:00-03:00")
    evento = Evento.new(id, nombre, inicio, fin)

    recursoSala = RecursoSala.new("sala1", nil)
    
    recursoSala.validar_asignacion_evento(evento)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento recurrente con fechas a las 9hs y 18 hs y frecuencia diaria con 30 dias pasa la validacion' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-08-01T09:00:00-03:00")
    fin = DateTime.strptime("2017-08-01T18:00:00-03:00")
    
    fin_recurrencia = Date.strptime("2017-08-31")
    evento = EventoRecurrente.new(id, nombre, inicio, fin, FrecuenciaDiaria.new(), fin_recurrencia)

    recursoSala = RecursoSala.new("sala1", nil)
    
    recursoSala.validar_asignacion_evento(evento)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento recurrente con fechas a las 9hs y 18 hs y frecuencia diaria con 31 dias falla la validacion' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-08-01T09:00:00-03:00")
    fin = DateTime.strptime("2017-08-01T18:00:00-03:00")
    
    fin_recurrencia = Date.strptime("2017-09-01")
    evento = EventoRecurrente.new(id, nombre, inicio, fin, FrecuenciaDiaria.new(), fin_recurrencia)

    recursoSala = RecursoSala.new("sala1", nil)
    
    expect{recursoSala.validar_asignacion_evento(evento)}
    .to raise_error(ExcepcionCantidadDiasRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento recurrente con fechas a las 9hs y 18 hs y frecuencia diaria con 60 dias falla la validacion' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-08-01T09:00:00-03:00")
    fin = DateTime.strptime("2017-08-01T18:00:00-03:00")
    
    fin_recurrencia = Date.strptime("2017-10-01")
    evento = EventoRecurrente.new(id, nombre, inicio, fin, FrecuenciaDiaria.new(), fin_recurrencia)

    recursoSala = RecursoSala.new("sala1", nil)
    
    expect{recursoSala.validar_asignacion_evento(evento)}
    .to raise_error(ExcepcionCantidadDiasRecurso)
  end

  it 'Al llamar al metodo validar_asignacion_evento con un evento recurrente con fechas a las 8hs y 18 hs y frecuencia diaria con 30 dias falla la validacion' do 
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.strptime("2017-07-01T08:00:01-03:00")
    fin = DateTime.strptime("2017-07-01T17:59:59-03:00")
    
    fin_recurrencia = Date.strptime("2017-07-30")
    evento = EventoRecurrente.new(id, nombre, inicio, fin, FrecuenciaSemanal.new(), fin_recurrencia)

    recursoSala = RecursoSala.new("sala1", nil)
    
    expect{recursoSala.validar_asignacion_evento(evento)}
    .to raise_error(ExcepcionFechaAsignacionRecurso)
  end
end