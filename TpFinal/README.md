
Decisiones de Diseño:

 1- Los nombres de los eventos y calendarios son guardados en minúscula (downcase)
 2- Los calendarios se guardan en archivos. Un archivo por cada calendario.
 3- Todos los calendarios estaran en un directorio llamado "Calendarios". El mismo estará en el mismo directorio donde se encuntran los directorios "model" y "spec"
 4- Previo a iniciar la aplicacion se debe tener creado el directorio "calendarios"

 Consideraciones:
 
 - Desde la clase controller al leer el json, que me permitira crear los distintos objetos, se llama el nombre de la llave en cada uno de los metodos segun corresponda. Esto puede generar inconveniente si se decide cambiar el nombre de la llave del json pues deberian recorrerse todos los metodos donde se llamen esas llaves y cambiarlos. Esto tambien viola  el pricipio de single responsability. 
 Una solucion puede consistir en generar un objeto que se encarge de leer el Json y me devuelva los datos mediante metodos. De esta manera si cambia el nombre de la llave solo modificar el metodo de esta clase en particular.
