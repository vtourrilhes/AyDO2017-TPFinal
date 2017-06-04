require 'rspec' 
require_relative '../model/evento'

describe 'Evento' do

  let(:evento) { Evento.new }  

  it 'actualizar evento inicio = 2017-06-03 20:00:00' do
  	nuevoInicio = Time.new("2017", "06","03","20","00")
  	nuevoFin = Time.new("2017", "06","03","21","00")

  	evento.actualizarEvento(nuevoInicio, nuevoFin)

    expect(evento.inicio).to eq nuevoInicio
    expect(evento.fin)
  end

 end