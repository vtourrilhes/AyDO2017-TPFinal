require 'rspec'
require_relative '../model/persistidor_de_datos'

describe 'RecursoProyector' do 
  it 'Al llamar guardar elmento abre el archivo y ejecuta dump marshal' do
    fileDouble = double("fileDouble")
    marshalDouble = double("marshalDouble")
    archivoDouble = double("archivoDouble")
    allow(fileDouble).to receive(:open).with("ruta1", "w") { archivoDouble }

    expect(archivoDouble).to receive(:close)
    expect(fileDouble).to receive(:open).with("ruta1", "w")
    expect(marshalDouble).to receive(:dump).with("elemento", archivoDouble)
    persistidor = PersistidorDeDatos.new("ruta1", fileDouble, marshalDouble)

    persistidor.guardar_elemento("elemento")

  end

  it 'Al llamar cargar_elemento abre el archivo y ejecuta load marshal' do
    fileDouble = double("fileDouble")
    marshalDouble = double("marshalDouble")
    archivoDouble = double("archivoDouble")

    allow(fileDouble).to receive(:file?).with("ruta1") { true }
    allow(fileDouble).to receive(:open).with("ruta1", "r") { archivoDouble }
    
    expect(fileDouble).to receive(:open).with("ruta1", "r")
    expect(marshalDouble).to receive(:load).with(archivoDouble)
    persistidor = PersistidorDeDatos.new("ruta1", fileDouble, marshalDouble)

    persistidor.cargar_elemento()

  end
end