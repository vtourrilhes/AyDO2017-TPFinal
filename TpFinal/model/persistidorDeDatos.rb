require_relative '../model/repositorioCalendarios'
require_relative '../model/convertidorJson'
require 'fileutils'
require 'json'
require 'time'

class PersistidorDeDatos

	attr_accessor :path_calendarios
	attr_accessor :convertidorJson

	def initialize
		self.path_calendarios = "./calendarios/"
		convertidorJson = ConvertidorJson.new
	end

	def guardarDatosRepositorioCalendarios(repositorioCalendarios)		
		repositorioCalendarios.calendarios.values.each do |calendario|
			File.open("#{path_calendarios}#{calendario.nombre}.txt", 'w') do |file|
				calendario.eventos.values.each do |evento| 
					json_string = convertidorJson(evento)
					file.puts(json_string.to_json) 
				end
			end
		end
	end

	def cargarDatosCalendarios(repositorioCalendarios)
		Dir.glob("#{path_calendarios}*").each do |fullNameFile|
			nameFile = fullNameFile.gsub('./calendarios/', '')
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

	def eliminarCalendario(nombreCalendario)
		FileUtils.rm("#{path_calendarios}#{nombreCalendario}.txt")
	end
end