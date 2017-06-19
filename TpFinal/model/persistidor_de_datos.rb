require_relative '../model/repositorio_calendarios'
require_relative '../model/conversor_json'
require_relative '../model/json_evento'
require_relative '../model/conversor_string_a_fecha_tiempo'
require 'fileutils'
require 'json'
require 'time'

class PersistidorDeDatos

	attr_accessor :path_calendarios
	attr_accessor :convertidor_json

	def initialize
		@path_calendarios = './calendarios/'
		@convertidor_json = ConversorJson.new
	end

	def guardar_repositorio(repositorio)
		repositorio.calendarios.values.each do |calendario|
			File.open("#{path_calendarios}#{calendario.nombre}.txt", 'w') do |file|
				calendario.obtener_eventos.each do |evento|
					json_string = @convertidor_json.obtener_json_evento(evento)
					file.puts(json_string.to_json)
				end
			end
		end
	end

	def cargar_repositorio(repositorio)
		Dir.glob("#{path_calendarios}*").each do |fullNameFile|
			name_file = fullNameFile.gsub('./calendarios/', '')
			calendario = repositorio.crear_calendario(name_file.gsub('.txt', ''))
			File.open("#{path_calendarios}#{name_file}", 'r') do |file|
				while (line = file.gets)
					json = JsonEvento.new(JSON.parse(line))
					id = json.obtenerIdEvento
					nombre = json.obtenerNombreEvento
					inicio = convertir_string_a_time(json.obtenerFechaInicio)
					fin = convertir_string_a_time(json.obtenerFechaFin)
					calendario.crear_evento(id, nombre, inicio, fin)
				end
			end
		end
		repositorio
	end

	def eliminar_calendario(nombre)
		FileUtils.rm("#{path_calendarios}#{nombre}.txt")
	end
end