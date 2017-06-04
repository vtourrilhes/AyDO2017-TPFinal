require 'rspec' 
require_relative '../model/evento'
require_relative '../model/calendario'

describe 'Evento' do

  let(:evento) { Evento.new(Time.now, Time.now, "Aydoo", Calendario.new("TpFinal")) }  

  it 'actualizar evento inicio = 2017-06-03 20:00:00' do
  	nuevoInicio = Time.new("2017", "06","03","20","00")
  	nuevoFin = Time.new("2017", "06","03","21","00")

  	evento.actualizarEvento(nuevoInicio, nuevoFin)

    expect(evento.inicio).to eq nuevoInicio
    expect(evento.fin).to eq nuevoFin
  end

 end