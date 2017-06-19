___
# Analisis Preliminar
___

## ¿Está la documentación/diagramas completos?
* En cuanto al archivo README cumple con tener el link al badge de travis pero no con la documentacion referida a cuestiones de diseño; Dicha documentacion se encontro en otro archivo.
* La documentacion referida a cuestiones de diseño se contradice. 
    >3- Todos los calendarios estaran en un directorio llamado "Calendarios"
    >4- Previo a iniciar la aplicacion se debe tener creado el directorio "calendarios"
* En la documentacion referida a cuestiones de diseño hay cosas que no corresponden al tema en cuestion.
    >5- El id del evento es unico dentro de un mismo calendario, pudiendo repetirse el id en calendarios distintos
    >6- Es posible tener varios eventos con el mismo nombre
    >7- Para eliminar un evento se debe especificar el id del evento a eliminar y calendario del cual se quiere eliminar
    >8- Es posible consultar todos los eventos que tengan un id en particular

* En un apartado puntual del README donde se detallan los las cuestiones de diseño hay un item que da aviso sobre que los diagramas quedaron desactualizadas. Sacando ese punto de lado cuenta tanto con diagrama de clase como de secuencias. Esta documentacion se encuentra como lo pedia el enunciado dentro de la carpeta docs.

## ¿Está correctamente utilizada la notación UML?

* Se ausenta la cardinalidad en el diagrama de clase. 80% de las relaciones no poseen cardinalidad.
* Los atributos y tipo de datos utilizados no son coherentes con las relaciones detalladas. Ejemplos:
    * Calendario tiene un atributo eventos de tipo Evento y la relacion entre estos tienen una cardinalidad de o2m o m2m ( dado que esta incompleta la cardinalidad no se puede identificar )
    * GeneradorDeRecurrencia tiene un atributo eventos de tipo Evento y no tiene relacion alguna con Evento.

## ¿Son consistentes los diagramas con el código?

Si bien en un apartado puntual del README donde se detallan los las cuestiones de diseño hay un item que da aviso sobre que los diagramas quedaron desactualizadas a continuacion se detallan las diferencias:
* Tipos de atributos no coinciden. Un ejemplo podria ser eventos en Calendario.
* Firma de metodos no coinciden. Un ejemplo podria ser el metodo "agregarEvento" el cual recibe como parametro evento en el diagrama y nuevoEvento en el codigo.
* Al no contar con cardinalidad no se identifica bien sin las relaciones son consistentes entre codigo y diagrama.
* En el diagrama hay clases que tienen atributos que en el codigo no existen y en el diagrama no tienen sentido. Ejemplo: PersistidorDeDatos tiene como atributo un persistidorDeDatos de tipo PersistidorDeDatos.
* En el diagrama figura ServicioApp cuando en el codigo no hay una clase con dicho nombre. Del analisis realizado se relaciona con el archivo app.rb

## ¿Implementa toda la funcionalidad pedida?

No cumple con la funcionalidad solicitada.

* Si se crea un evento recurrente, y luego se piden los eventos de la aplicación (curl localhost:4567/eventos), se retorna más de un evento (tantos como entren teniendo en cuanta la frecuencia y el fin de la recurrencia), y se le asigna a cada uno un id distinto.
* Si se quiere realizar una actualización en un evento, exige indicarle a qué calendario pertenece. Caso contrario, arroja el error "404 Not Found: No se especifico el calendario del evento".
* Si se quiere eliminar un evento (curl -X DELETE localhost:4567/eventos/evento1), se recibe el error "Sinatra doesn't know this ditty"
* Permite crear un calendario sin nombre (curl -X POST -d '{"nombre":""}' localhost:4567/calendarios).
* Al intentar modificar el inicio de un evento, también se modifica la hora fin de ese evento.
* No permite ingresar recurrencia a un evento que no es recurrente. No arroja error, pero no realiza el cambio solicitado.
* Como los eventos recurrentes se crean como múltiples eventos simples, entonces tampoco nos permite realizar cambios sobre la recurrencia del evento.

## ¿Qué observaciones tiene sobre el modelo?

* No respeta convenciones:
    * Dejando de lado librerias y funciones provistas por el lenguaje hay uso de diferentes idiomas
    * No respeta identacion de codigo.
    * No respeta snake case para atributos y metodos.
    * No respeta convencion para nombre de archivos.
    * Hay codigo comentado sin utilizar. 
    * Hay imports que no se utilizan.
* Se utilizan magic numbers.
    ```sh
    frecuencia = recurrencia.frecuencia.peridodDeRepeticion*(24*3600)
    ```
* No hay uso de polimorfismo
* En los test no hay uso de mocking
* Los test estan mezclados, es decir, en el archivo que referencia a pruebas de Calendario se realizan pruebas sobre ValidadorDeEvento.
* Existen varios clases para la cumplir el rol de controlador cuando no parece necesario. ServicioApp,  ControllerCalendarios, JsonEvento, JsonCalendario.
* No hay excepciones particulares. Solo se utilizan excepciones genericas y esto influye en la respuesta que devuelve la api.
* Todos los metodos son publicos y algunos de ellos no son utilizados por otras clases. Ejemplo:
    * Metodo "inicializarRepositorio" en la clase ControllerCalendarios
* Rompe con el principio de inversion de dependencia. Ejemplos:
    * En el metodo "crearEventoRecurrente" de la clase Calendario cuando instancia un GeneradorDeRecurrencia. 
    * En el metodo "crearCalendario" de la clase ControllerCalendarios cuando instancia un JsonCalendario 

@TODO Identificar con cuales otros principios no cumple y ejemplificar

## ¿Tiene suficiente pruebas?

La cobertura de las pruebas es de un 78.63%. Se hace muy dificil seguir que pruebas hicieron y cuales no dado que los test estan mal organizados. Uno espera que al abrir el archivo de test de Calendarios se encuentren las pruebas a los metodos de dicha clase mientras que lo que uno encuentra son pruebas referentes a otras clases, como por ejemplo ValidadorDeEvento. Por ejemplo en los test de calendarios no hay ningun test para el metodo "crearEventoRecurrente".

___

# Analisis Cambios
___

## Camino A
* Refactors para cumplir con convenciones y que sea mas simple la lectura.
* Identificar que metodos deberian ser privados y cuales publicos para identificar bien las pruebas faltantes.
* Crear excepciones particulares y modificar los test para ver si hay casos de pruebas incorrectos.
* Uninir las clases referidas al uso del controlador y parse de datos.
* Hacer que el codigo y el diagrama de clases sean coherentes.
* Hacer los cambios para que cumpla con funcionalidad TP parte 1
* Hacer analisis para funcionalidad TP parte 2
* ...

## Camino B
* Intentar realizar el cambio solicitado y luego comenzar con refactors. Con esta opcion existe riesgo de trabarse y no llegar nada.

## Camino C
* Pisar completamente el codigo y hacer el analisis de la funcionalidad TP parte 2.
