require 'json'

class ConversorJson

	def obtener_json_calendario(calendario)
		{nombre: calendario.nombre}
	end

	def obtener_array_json_calendarios(calendarios)
		array_json = []
		calendarios.each do |calendario|
			array_json.push(obtener_json_calendario(calendario))
		end
		array_json
	end

	def obtener_json_evento(evento)
		{
				calendario: evento.calendario.nombre,
				id: evento.id,
				nombre: evento.nombre,
				fecha_inicio: evento.fecha_inicio,
				fecha_fin: evento.fecha_fin
		}
	end

	def obtener_array_json_eventos(eventos)
		array_json = []
		eventos.each do |evento|
			array_json.push(obtener_json_evento(evento))
		end
		array_json
	end
end