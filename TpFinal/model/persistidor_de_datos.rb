require_relative '../model/repositorio_calendarios'
require_relative '../model/conversor_json'
require_relative '../model/json_evento'
require_relative '../model/conversor_string_a_fecha_tiempo'
require 'fileutils'
require 'json'
require 'time'

class PersistidorDeDatos

	attr_accessor :ruta_directorio
	attr_accessor :conversor_json

	def initialize
		@ruta_directorio = './calendarios/'
		@conversor_json = ConversorJson.new
	end

	def guardar_repositorio(repositorio)
		repositorio.calendarios.values.each do |calendario|
			File.open("#{@ruta_directorio}#{calendario.nombre}.txt", 'w') do |file|
				calendario.obtener_eventos.each do |evento|
					json_string = @conversor_json.obtener_json_evento(evento)
					file.puts(json_string.to_json)
				end
			end
		end
	end

	def cargar_repositorio(repositorio)
		Dir.glob("#{@ruta_directorio}*").each do |fullNameFile|
			name_file = fullNameFile.gsub('./calendarios/', '')
			calendario = repositorio.crear_calendario(name_file.gsub('.txt', ''))
			File.open("#{@ruta_directorio}#{name_file}", 'r') do |file|
				while (line = file.gets)
					json = JsonEvento.new(JSON.parse(line))
					id = json.obtener_id_evento
					nombre = json.obtener_nombre_evento
					inicio = convertir_string_a_time(json.obtener_fecha_inicio)
					fin = convertir_string_a_time(json.obtener_fecha_fin)
					calendario.crear_evento(id, nombre, inicio, fin)
				end
			end
		end
		repositorio
	end

	def eliminar_calendario(nombre)
		FileUtils.rm("#{@ruta_directorio}#{nombre}.txt")
	end
end