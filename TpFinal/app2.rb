require 'sinatra'
require_relative 'model/persistidorDeDatos.rb'
require_relative 'model/repositorioCalendarios.rb'

set :db, PersistidorDeDatos.new

get '/calendarios' do
	repo = RepositorioCalendarios.new
	calendario = Calendario.new("aydoo")
	#repo.agregarCalendario(calendario)

	settings.db.cargarDatosCalendarios(repo)
	
end