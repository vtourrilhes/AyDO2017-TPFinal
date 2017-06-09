require_relative '../model/repositorioCalendarios'
require 'json'

class PersistidorDeDatos

	attr_accessor :path_calendarios

	def initialize
		self.path_calendarios = "../calendarios/"
	end

	def guardarDatosRepositorioCalendarios(repositorioCalendarios)		
		repositorio.calendarios.values.each do |calendario|
			File.open("#{path_calendarios}#{calendario.nombre}.txt", 'w') do |file|
				calendario.eventos.values.each do |evento| 
					json_string = evento.obtenerJsonString
					file.puts(json_string.to_json) 
				end
			end
		end
	end

	def cargarDatosCalendarios(repositorioCalendarios)
		Dir.glob("#{path_calendarios}*").each do |fullNameFile|
			nameFile = fullNameFile.gsub('../calendarios/', '')
			calendario = repositorioCalendarios.crearCalendario(nameFile.gsub('.txt',''))

			File.open("#{path_calendarios}#{nameFile}", 'r') do |file|				
				while (line = file.gets)					
				    json = JSON.parse(line)
				    inicio = Time.parse(json['fecha_inicio'])
				    fin = Time.parse(json['fecha_fin'])

				    calendario.crearEvento(json['id_evento'], inicio, fin)				    
				end
			end
		end

		return repositorioCalendarios
	end
end