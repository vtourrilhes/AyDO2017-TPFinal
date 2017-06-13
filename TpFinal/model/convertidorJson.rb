require 'json'

class ConvertidorJson

	def obtenerJsonCalendario(calendario)
		jsonString = {nombre: calendario.nombre}		

		return jsonString
	end

	def obtenerArrayJsonCalendarios(calendarios)	
		arrayjson = []

		calendarios.each do |calendario|
			arrayjson.push(obtenerJsonCalendario(calendario))
		end

		return arrayjson
	end

	def obtenerJsonEvento(evento)
		jsonString = {
			calendario: evento.calendario.nombre,
			id: evento.id, 
			nombre: evento.nombre, 
			inicio: evento.inicio, 
			fin: evento.fin
		}		

		return jsonString
	end

	def obtenerArrayJsonEventos(eventos)	
		arrayjson = []

		eventos.each do |evento|
			arrayjson.push(obtenerJsonEvento(evento))
		end

		return arrayjson
	end

end