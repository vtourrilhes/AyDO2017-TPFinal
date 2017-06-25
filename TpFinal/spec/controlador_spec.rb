require 'rspec'
require_relative '../model/controlador'
require 'json'

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
    builder_de_recursos = double('Builder De Recursos')

    Controlador.new(
      repositorio_calendarios,
      repositorio_recursos,
      repositorio_frecuencias,
      validador_unicidad_eventos,
      persistidor_de_calendarios,
      persistidor_de_recursos,
      builder_de_recursos
    )
  end

  it 'CrearCalendarioDeberiaDevovlerElCalendarioCreado' do

    controlador = Controlador.new(
        double('Repositorio Calendrios',:agregar_calendario=>nil),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    calendarioExpected = '{"nombre":"calendario1"}'

    expect(controlador.crear_calendario(JSON.parse(calendarioExpected)).nombre).to eq 'calendario1'

  end


  it 'ObtenerCalendarioDeberiaDevovlerElCalendarioSolicitado' do

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendario=>Calendario.new("calendario1")),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    calendarioExpected = Calendario.new('calendario1')

    expect(controlador.obtener_calendario("calendario1").nombre).to eq calendarioExpected.nombre

  end

  it 'ObtenerCalendariosDeberiaDevovlerTodosLosCalendarios' do

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[Calendario.new("calendario1"),Calendario.new("calendario2"),Calendario.new("calendario3")]),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    calendarioExpected = Calendario.new('calendario1')

    expect(controlador.obtener_calendarios().size).to eq 3

  end

  #TODO testear bien
  it 'CrearEvento' do

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[Calendario.new("calendario1"),Calendario.new("calendario2"),Calendario.new("calendario3")]),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    calendarioExpected = Calendario.new('calendario1')

    expect(controlador.obtener_calendarios().size).to eq 3

  end


  #TODO testear bien
  it 'ActualizarEvento' do

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[Calendario.new("calendario1"),Calendario.new("calendario2"),Calendario.new("calendario3")]),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    calendarioExpected = Calendario.new('calendario1')

    expect(controlador.obtener_calendarios().size).to eq 3

  end


  it 'ObtenerTodosLosEventosDeberiaDevolverTodosLosEventosDeTodosLosCalendarios' do

    calendario1 = Calendario.new("calendario1")
    calendario2 = Calendario.new("calendario2")
    calendario3 = Calendario.new("calendario3")

    evento1 = Evento.new('evento1','fiesta',DateTime.now,DateTime.now+1)
    evento2 = Evento.new('evento2','clase',DateTime.now+2,DateTime.now+3)
    calendario1.agregar_evento evento1
    calendario2.agregar_evento evento2

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[calendario1,calendario2,calendario3]),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    calendarioExpected = Calendario.new('calendario1')

    expect(controlador.obtener_todos_los_eventos().size).to eq 2

  end


  it 'ObtenerEventosDeberiaDevolverLosEventosDeUnCalendario' do

    calendario1 = Calendario.new("calendario1")
    calendario2 = Calendario.new("calendario2")
    calendario3 = Calendario.new("calendario3")

    evento1 = Evento.new('evento1','fiesta',DateTime.now,DateTime.now+1)
    evento2 = Evento.new('evento2','clase',DateTime.now+2,DateTime.now+3)
    calendario1.agregar_evento evento1
    calendario1.agregar_evento evento2

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendario=>calendario1),
        double('Repositorio Recursos'),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    expect(controlador.obtener_eventos('calendario1').size).to eq 2

  end



  it 'ObtenerTodosLosRecursosDeberiaDevolver2' do

    calendario1 = Calendario.new("calendario1")
    calendario2 = Calendario.new("calendario2")
    calendario3 = Calendario.new("calendario3")

    evento1 = Evento.new('evento1','fiesta',DateTime.now,DateTime.now+1)
    evento2 = Evento.new('evento2','clase',DateTime.now+2,DateTime.now+3)

    sala = RecursoSala.new('sala1',nil)
    proyector = RecursoProyector.new('proyector1','funcional')

    evento1.asignar_recurso sala
    evento2.asignar_recurso proyector

    calendario1.agregar_evento evento1
    calendario1.agregar_evento evento2


    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[calendario1,calendario2,calendario3]),
        double('Repositorio Recursos',:obtener_recursos=>[sala,proyector]),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil),
        double('Builder De Recursos')
    )

    expect(controlador.obtener_todos_los_recursos().size).to eq 2

  end

  it 'CrearRecursoDeberiaDevolverElRecursoCreadoYCoincidirConElNombreEsperado' do

    calendario1 = Calendario.new("calendario1")
    calendario2 = Calendario.new("calendario2")
    calendario3 = Calendario.new("calendario3")

    evento1 = Evento.new('evento1','fiesta',DateTime.now,DateTime.now+1)
    evento2 = Evento.new('evento2','clase',DateTime.now+2,DateTime.now+3)

    sala = RecursoSala.new('sala1',nil)
    proyector = RecursoProyector.new('proyector1','funcional')

    evento1.asignar_recurso sala
    evento2.asignar_recurso proyector

    calendario1.agregar_evento evento1
    calendario1.agregar_evento evento2


    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[calendario1,calendario2,calendario3]),
        double('Repositorio Recursos',:obtener_recursos=>[sala,proyector],:agregar_recurso=>nil),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil,:guardar_elemento=>nil),
        double('Builder De Recursos',:crear=>RecursoProyector.new('proyector1','funcional'))
    )

    expect(controlador.crear_recurso('{"nombre","proyector1","tipo":"proyector"}').nombre).to eq 'proyector1'

  end


  it 'AsignarRecursoDeberiaAsociarUnRecursoAUnEvento' do

    calendario1 = Calendario.new("calendario1")
    calendario2 = Calendario.new("calendario2")
    calendario3 = Calendario.new("calendario3")

    evento1 = Evento.new('evento1','fiesta',DateTime.strptime("2017-03-31T09:00:00-03:00","%Y-%m-%dT%H:%M:%S%z"),DateTime.strptime("2017-03-31T10:00:00-03:00","%Y-%m-%dT%H:%M:%S%z"))
    evento2 = Evento.new('evento2','clase',DateTime.strptime("2017-03-31T11:00:00-03:00","%Y-%m-%dT%H:%M:%S%z"),DateTime.strptime("2017-03-31T12:00:00-03:00","%Y-%m-%dT%H:%M:%S%z"))

    sala = RecursoSala.new('sala1',nil)
    proyector = RecursoProyector.new('proyector1','funcional')

    controlador = Controlador.new(
        double('Repositorio Calendrios',:obtener_calendarios=>[calendario1,calendario2,calendario3]),
        double('Repositorio Recursos',:obtener_recursos=>[sala,proyector],:agregar_recurso=>nil),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos'),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil,:guardar_elemento=>nil),
        double('Builder De Recursos',:crear=>RecursoProyector.new('proyector1','funcional'))
    )

    controlador.asignar_recurso(sala,evento1)

    expect( evento1.recurso.nombre ).to eq 'sala1'

  end

  it 'CrearEventoDeberiaFallarSiLeDoyUnCalendarioInexistente' do

    calendario1 = Calendario.new("calendario1")

    sala = RecursoSala.new('sala1',nil)
    proyector = RecursoProyector.new('proyector1','funcional')

    repositorio_calendarios = double('Reppositorio Calendarios',:obtener_calendarios=>[])
    allow(repositorio_calendarios).to receive(:obtener_calendario).and_raise(ExcepcionCalendarioInexistente)

    controlador = Controlador.new(
        repositorio_calendarios,
        double('Repositorio Recursos',:obtener_recurso=>nil,:agregar_recurso=>nil),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos',:validar=>nil),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil,:guardar_elemento=>nil),
        double('Builder De Recursos',:crear=>RecursoProyector.new('proyector1','funcional'))
    )

    recurso_json = '{
        "calendario": "calendario50",
        "id": "evento1",
        "nombre": "evento uno",
        "inicio": "2017-07-31T10:00:00-03:00",
        "fin": "2017-07-31T11:00:00-03:00",
        "recurso": {
            "nombre": "sala100"
          }
        }'

    expect{ controlador.crear_evento(JSON.parse(recurso_json)) }.
        to raise_error(ExcepcionCalendarioInexistente)

  end

  it 'ActualizarEventoDeberiaFallarSiLeAsignoUnEventoQueNoExiste' do

    calendario1 = Calendario.new("calendario1")

    sala = RecursoSala.new('sala1',nil)
    proyector = RecursoProyector.new('proyector1','funcional')

    repositorio_calendarios = double('Reppositorio Calendarios',:obtener_calendario=>calendario1,:obtener_calendarios=>[calendario1])

    controlador = Controlador.new(
        repositorio_calendarios,
        double('Repositorio Recursos',:obtener_recurso=>[sala,proyector],:agregar_recurso=>nil),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos',:validar=>nil),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil,:guardar_elemento=>nil),
        double('Builder De Recursos',:crear=>RecursoProyector.new('proyector1','funcional'))
    )

    recurso_json = '{
        "calendario": "calendario1",
        "id": "evento1",
        "nombre": "evento uno",
        "inicio": "2017-07-31T10:00:00-03:00",
        "fin": "2017-07-31T11:00:00-03:00",
        "recurso": {
            "nombre": "sala100"
          }
        }'

    expect{ controlador.actualizar_evento(JSON.parse(recurso_json)) }.
        to raise_error(ExcepcionEventoInexistente)

  end


  it 'ActualizarEventoDeberiaFallarSiLeAsignoUnRecursoInexistente' do

    calendario1 = Calendario.new("calendario1")

    sala = RecursoSala.new('sala1',nil)
    proyector = RecursoProyector.new('proyector1','funcional')

    evento1 = Evento.new('evento1','fiesta',DateTime.strptime("2017-03-31T09:00:00-03:00","%Y-%m-%dT%H:%M:%S%z"),DateTime.strptime("2017-03-31T10:00:00-03:00","%Y-%m-%dT%H:%M:%S%z"))
    calendario1.agregar_evento(evento1)
    repositorio_calendarios = double('Reppositorio Calendarios',:obtener_calendario=>calendario1,:obtener_calendarios=>[calendario1])

    controlador = Controlador.new(
        repositorio_calendarios,
        double('Repositorio Recursos',:obtener_recurso=>[sala,proyector],:agregar_recurso=>nil),
        double('Repositorio Frecuencias',:frecuencias=>{}),
        double('Validador Unicidad Eventos',:validar=>nil),
        double('Persistidor De Calendarios',:guardar_elemento=>nil,:cargar_elemento=>nil),
        double('Persistidor De Recursos',:cargar_elemento=>nil,:guardar_elemento=>nil),
        double('Builder De Recursos',:crear=>RecursoProyector.new('proyector1','funcional'))
    )

    allow(controlador.repositorio_recursos).to receive(:obtener_recurso).and_raise(ExcepcionRecursoInexistente)


    recurso_json = '{
        "calendario": "calendario1",
        "id": "evento1",
        "nombre": "evento uno",
        "inicio": "2017-07-31T10:00:00-03:00",
        "fin": "2017-07-31T11:00:00-03:00",
        "recurso": {
            "nombre": "sala100"
          }
        }'

    expect{ controlador.actualizar_evento(JSON.parse(recurso_json)) }.
        to raise_error(ExcepcionRecursoInexistente)

  end


end