___
# Analisis Preliminar
___
 
## ¿Está la documentación/diagramas completos?
 
* Hay diagramas de clases y de secuencia, pero no se reflejan con el código del proyecto      (Ver detalles en la tercer pregunta).
 
## ¿Está correctamente utilizada la notación UML?
 
* La notación UML está bien utilizada, con la excepción de que las cardinalidades entre clases no figuran y eso lleva a confusiones.
* La única cardinalidad que figura es entre Calendario y Evento, que se ve reflejada en el código.
* Fuera de eso, el diagrama es claro y de una mirada rápida se puede entender como funcionan todas las clases en conjunto.
 
## ¿Son consistentes los diagramas con el código?
 
* La clase ServicioApp que figura en el UML no existe (En caso de ser app, los métodos no coinciden).
* ControllerCalendarios que figura en el UML se llama Controlador y no tiene los mismos atributos ni métodos del modelo (Faltan todo lo referido a recursos).
* Los validadores (Validad de evento, calendario y de json) no existen, solo existe ‘validar_unicidad_evento’
* RepositorioCalendarios y PersistidorCalendarios en la clase ControllerCalendarios si están como figura en el UML, pero no lista métodos privados que deberían estar listados (Uno de estos métodos por ejemplo es ‘validar_unicidad_calendario’, debería figurar en el uml así sabemos que el repositorio se encarga de eso, y no los validadores como se podría asumir mirando el diagrama).
*El persistidorDeDatos del diagrama no se refleja nada en el código.
 
* En resumen el diagrama de clases no refleja las relaciones entre las clases del modelo.
 
* Los diagramas de actividad también están desactualizados con respecto al código
 
## ¿Implementa toda la funcionalidad pedida?
 
* Al invocar borrar calendario el calendario se elimina en tanto la aplicación se encuentre corriendo, pero si se detiene la aplicación y se vuelve a iniciar el, calendario volverá a estar listado. 
* La funcionalidad de actualización de evento no actualiza la recurrencia de los eventos. Lanza un error de 400 bad request. NO está cumpliendo el caso 6 del doc.
* No cumple con la funcionalidad solicitada.
 
 
 
 
## ¿Qué observaciones tiene sobre el modelo?
 
* A nivel de esquema de objetos se ve que se intentó modelar en base a clase de Validadores pero solo existe el ValidadorDeUnicidad
* Las clases de repositorio contienen las validaciones
* La clase PersistidorDeDatos tiene una dependencia directa contra las clases File y Marshal que son nativas de ruby lo que viola el principio de Inversión de Dependencia ya que dentro de la propia clase se obtienen estos objetos.
* La clase de Evento contiene validación de fechas si en un dia futuro se decide agregar una nueva validación hay que tocar esta clase lo que viola Open/Close
* La clase EventoRecurrente aparentemente guarda solo el nombre del objeto Recurso(un string) mientras que la clase Evento guarda el objeto Recurso
 
* El codigo se encuentra bien identado
* En app.rb hay lógica para atrapar excepciones lanzadas desde el controlador
 
## ¿Tiene suficiente pruebas?
 
* La clase controlador que contiene lógica de llamada a los otros objetos de validación y creación de calendarios no tiene tests unitarios. Solo hay un test de inicialización que no verifica nada y no se prueba nada de la lógica del Controlador. Lo cual hace dudar del funcionamiento de esa clase.
* La clase PersistidorDeDatos no tiene tests.
* La clase ReglaIntervaloEventos no tiene tests
 
___
 
# Analisis Cambios
___
 
* Arreglar métodos del controlador para que cumplan la parte 1 del tp y darle cobertura con tests unitario.
* Realizar cambios a las clases para lograr crear distintos tipos de recursos.
* Agregar clases para Recursos Sala y Recursos Proyector
* Tocar clase EventoRecurrente para que devuelva la frecuencia del evento
* Tocar clase Evento para que devuelva nil al pedirle una frecuencia
* Agregar las validaciones para la asignación de Salas y Proyectores

