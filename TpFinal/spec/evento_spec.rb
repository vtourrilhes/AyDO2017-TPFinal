require 'rspec'
require_relative '../model/evento'

describe 'Evento' do
  it 'Se debe crear un evento a partir de un id, nombre, inicio y fin' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    Evento.new(id, nombre, inicio, fin)
  end

  it 'Deberia poder obtener el id' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    expect(evento.id).to eq id
  end

  it 'Error al intentar modificar el id' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    expect {evento.id = 'nuevo_id'}.to raise_error
  end

  it 'Deberia poder obtener el nombre' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    expect(evento.nombre).to eq nombre
  end

  it 'Deberia poder obtener el inicio' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    expect(evento.fecha_inicio).to eq inicio
  end

  it 'Deberia poder obtener el fin' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    expect(evento.fecha_fin).to eq fin
  end

  it 'Deberia poder obtener el intervalo del evento' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    expect(evento.obtener_intervalo).to eq inicio..fin
  end

  it 'Deberia poder modificar su nombre' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    nuevo_nombre = 'nuevo_nombre'
    evento.nombre = nuevo_nombre
    expect(evento.nombre).to eq nuevo_nombre
  end

  it 'Deberia poder modificar su inicio' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    un_dia = 1
    nuevo_inicio = inicio - un_dia
    evento.fecha_inicio = nuevo_inicio
  end

  it 'Deberia poder modificar su fin' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    un_dia = 1
    nuevo_fin = fin + un_dia
    evento.fecha_fin = nuevo_fin
  end

  it 'Error al crear un evento con fin menor a inicio' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    un_dia = 1
    fin = inicio - un_dia
    expect do
      Evento.new(id, nombre, inicio, fin)
    end.to raise_error(ExcepcionIntervaloErroneo)
  end

  it 'Error al modificar fin y que fin sea menor a inicio' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    un_dia = 1
    nuevo_fin = inicio - un_dia
    expect do
      evento.fecha_fin = nuevo_fin
    end.to raise_error(ExcepcionIntervaloErroneo)
  end

  it 'Error al modificar inicio y que fin sea menor a inicio' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    un_dia = 1
    nuevo_inicio = inicio + un_dia
    expect do
      evento.fecha_inicio = nuevo_inicio
    end.to raise_error(ExcepcionIntervaloErroneo)
  end

  it 'Error al modificar inicio e intervalo supere maximo' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    mas_de_tres_dias = 3.1
    nuevo_inicio = inicio - mas_de_tres_dias
    expect do
      evento.fecha_inicio = nuevo_inicio
    end.to raise_error(ExcepcionIntervaloMaximo)
  end

  it 'Error al modificar fin e intervalo supere maximo' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    mas_de_tres_dias = 3.1
    nuevo_fin = inicio + mas_de_tres_dias
    expect do
      evento.fecha_fin = nuevo_fin
    end.to raise_error(ExcepcionIntervaloMaximo)
  end

  it 'Deberia poder modificar fin e intervalo no supere maximo' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    casi_tres_dias = 2.99
    nuevo_fin = inicio + casi_tres_dias
    evento.fecha_fin = nuevo_fin
  end

  it 'Deberia poder modificar inicio e intervalo no supere maximo' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    casi_tres_dias = 2.99
    nuevo_inicio = inicio - casi_tres_dias
    evento.fecha_inicio = nuevo_inicio
  end

  it 'Deberia devolver un diccionario con sus atributos si le pido to_h' do
    fecha_inicio = DateTime.now
    fecha_fin = DateTime.now
    hash = {
      'id' => 'id',
      'nombre' => 'nombre',
      'fecha_inicio' => fecha_inicio,
      'fecha_fin' => fecha_fin,
      'recurso' => {}
    }
    expect(Evento.new('id', 'nombre', fecha_inicio, fecha_fin).to_h).to eq(hash)
  end

  it 'Deberia poder asignar un recurso y obtenerlo' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    recurso = double('Recurso')
    evento.asignar_recurso(recurso)
    expect(evento.recurso).to eq recurso
  end

  it 'Deberia poder desasignar un recurso' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    recurso = double('Recurso')
    evento.asignar_recurso(recurso)
    evento.desasignar_recurso
    expect(evento.recurso).to eq nil
  end

  it 'Deberia poder actualizar un evento' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)
    evento.actualizar_evento(inicio + 1, fin + 1)
    expect(evento.fecha_fin).to eq fin + 1
    expect(evento.fecha_inicio).to eq inicio + 1
  end

  it 'Al pedirle el fin de la recurrencia a un evento no recurrente deberia devolve nil' do
    id = 'id_1'
    nombre = 'Evento 1'
    inicio = DateTime.now
    fin = inicio
    evento = Evento.new(id, nombre, inicio, fin)

    expect(evento.fin_recurrencia).to eq nil
  end

end