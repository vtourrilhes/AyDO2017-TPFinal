
Decisiones de Diseño:

 1- Los nombres de los eventos y calendarios son guardados en minúscula (downcase)
 2- Los calendarios se guardan en archivos. Un archivo por cada calendario.
 3- Todos los calendarios estaran en un directorio llamado "Calendarios". El mismo estará en el mismo directorio donde se encuentran los directorios "model" y "spec"
 4- Previo a iniciar la aplicacion se debe tener creado el directorio "calendarios"
 5- El id del evento es unico dentro de un mismo calendario, pudiendo repetirse el id en calendarios distintos
 6- Es posible tener varios eventos con el mismo nombre
 7- Para eliminar un evento se debe especificar el id del evento a eliminar y calendario del cual se quiere eliminar
 8- Es posible consultar todos los eventos que tengan un id en particular

 Consideraciones:
 
- Las clases JsonEvento y JsonCalendario se agregaron a ultimo momento con el objetivo de centralizar la obtencion de datos del json. De manera que si cambian las llaves de json solo habria que modificar esta clase.
- Por cuestiones de tiempo, los tipos de Frecuencia quedaron harcodeados en la clase controller, entendemos que no es lo mejor por lo que hubieramos querido levantar dicha parametría de un json y cargarlo en un diccionario para poder acceder a el.
