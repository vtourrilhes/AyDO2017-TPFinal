require 'rspec'
require_relative '../model/controlador'
require 'json'

describe 'ReglaIntervaloEventoSpec' do

  it 'ReglaIntervaloEventoDebriaFuncionarSiLeDoyUnIntervaloMenorA72Horas' do

    inicio = DateTime.strptime("2017-03-31T18:00:00-03:00","%Y-%m-%dT%H:%M:%S%z")
    fin =    DateTime.strptime("2017-04-01T21:00:00-03:00","%Y-%m-%dT%H:%M:%S%z")
    intervalo = (fin - inicio).to_i*24
    expect(ReglaIntervaloEvento.validar_horas(intervalo)).to eq nil

  end

  it 'ReglaIntervaloEventoDebriaFallarSiLeDoyUnIntervaloMayorA72Horas' do

    inicio = DateTime.strptime("2017-04-01T18:00:00-03:00","%Y-%m-%dT%H:%M:%S%z")
    fin =    DateTime.strptime("2017-04-22T21:00:00-03:00","%Y-%m-%dT%H:%M:%S%z")
    intervalo = (fin - inicio).to_i*24

    expect do
      expect(ReglaIntervaloEvento.validar_horas(intervalo))
    end.to raise_error(ExcepcionIntervaloMaximo)

  end



end
