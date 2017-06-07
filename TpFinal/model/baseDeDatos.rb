require_relative '../model/gestorcalendario'
require_relative '../model/configuracion'

class BaseDeDatos

	attr_accessor :gestorCalendario
	attr_accessor :path_calendarios

	def initialize
		self.gestorCalendario = GestorCalendario.new
		self.path_calendarios = "../calendarios/"
	end

	def crearCalendario				
		id_calendario = "Aydoo".downcase
		self.gestorCalendario.crearCalendario(id_calendario)
		self.gestorCalendario.crearEvento(Time.now, Time.now, "Parcial", id_calendario)
		self.gestorCalendario.crearEvento(Time.now, Time.now, "Final", id_calendario)
		self.gestorCalendario.crearEvento(Time.now, Time.now, "Tp", id_calendario)

		id_calendario = "MiCalendario".downcase
		self.gestorCalendario.crearCalendario(id_calendario)
		self.gestorCalendario.crearEvento(Time.now, Time.now, "Evento1", id_calendario)
		self.gestorCalendario.crearEvento(Time.now, Time.now, "Evento2", id_calendario)
		self.gestorCalendario.crearEvento(Time.now, Time.now, "Evento3", id_calendario)
	end

	def crearArchivosCalendarios
		crearCalendario
		
		gestorCalendario.calendarios.values.each do |calendario|
			File.open("#{path_calendarios}#{calendario.nombre}.txt", 'w') do |file|
				calendario.eventos.values.each do |evento| 
					file.puts("#{evento.nombre};#{evento.inicio};#{evento.fin}") 
				end
			end
		end
	end

	def mostrarCalendarios
		Dir.glob("#{path_calendarios}*").each do |fullNameFile|
			nameFile = fullNameFile.gsub('../calendarios/', '')
			puts(nameFile)
		end
	end

end