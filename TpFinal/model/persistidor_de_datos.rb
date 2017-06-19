require_relative '../model/repositorio_calendarios'
require_relative '../model/convertidor_json'
require_relative '../model/json_evento'
require_relative '../model/convertidor_string_a_fecha_tiempo'
require 'fileutils'
require 'json'
require 'time'

class PersistidorDeDatos

	attr_accessor :path_calendarios
	attr_accessor :convertidorJson

	def initialize
		self.path_calendarios = "./calendarios/"
		self.convertidorJson = ConvertidorJson.new
	end

	def guardarDatosRepositorioCalendarios(repositorioCalendarios)		
		repositorioCalendarios.calendarios.values.each do |calendario|
			File.open("#{path_calendarios}#{calendario.nombre}.txt", 'w') do |file|
				calendario.obtener_eventos().each do |evento|
					json_string = self.convertidorJson.obtenerJsonEvento(evento)
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
				    json = JsonEvento.new(JSON.parse(line))

				    
				    id = json.obtenerIdEvento()
		            nombre = json.obtenerNombreEvento()
		            inicio = convertirStringATime(json.obtenerFechaInicio())
				    fin = convertirStringATime(json.obtenerFechaFin())

				    calendario.crear_evento(id, nombre, inicio, fin)
				end
			end
		end
	
		return repositorioCalendarios
	end

	def eliminarCalendario(nombreCalendario)
		FileUtils.rm("#{path_calendarios}#{nombreCalendario}.txt")
	end
end