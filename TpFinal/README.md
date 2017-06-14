
<h2>Decisiones de Diseño</h2>

 <li>1- Los nombres de los eventos y calendarios son guardados en minúscula (downcase)</li>
 <li>2- Los calendarios se guardan en archivos. Un archivo por cada calendario.</li>
 <li>3- Todos los calendarios estaran en un directorio llamado "Calendarios". El mismo estará en el mismo directorio donde se encuentran los directorios "model" y "spec"</li>
 <li>4- Previo a iniciar la aplicacion se debe tener creado el directorio "calendarios"</li>
 <li>5- El id del evento es unico dentro de un mismo calendario, pudiendo repetirse el id en calendarios distintos</li>
 <li>6- Es posible tener varios eventos con el mismo nombre</li>
 <li>7- Para eliminar un evento se debe especificar el id del evento a eliminar y calendario del cual se quiere eliminar</li>
 <li>8- Es posible consultar todos los eventos que tengan un id en particular</li>

<h2>Deuda técnica</h2>

<li>1- La clase Generador Recurrencia tiene un code smell llamada Long Method, ademas de estar mal identado, lo cual lo hace confuso de entender. Es necesario modularizar el metodo.</li>
<li>2- El calendario se esta encargando utilizar al generador de recurrencia para generar los eventos dinamicamente segun la recurrencia dada. Esto rompe los principios singleResponsability y Liskov substitution ya que GeneradorDeRecurrencia deberia encargarse de generar los eventos recurrentemente dado un evento base y avisarle a diccionario los eventos que debe agregar.</li>
<li>3- En el ControllerCalendarios al actualizar eventos se se verifica con un condicional (if) que campos son o no nil y se decidi si debe actualizar o no. Este viola le principio de Open/close pues si aparece una nueva condicion de actualizacion deberia ir a modificar el controller. Deberia existir una clase ActualizarDeEvetno que se encargue de analizar los paramentro recibidos y actualizar en consecuencia.</li>
<li>4- Las clases JsonEvento y JsonCalendario se agregaron a ultimo momento con el objetivo de centralizar la obtencion de datos del json. De manera que si cambian las llaves de json solo habria que modificar esta clase.</li>
<li>5- Por cuestiones de tiempo, los tipos de Frecuencia quedaron harcodeados en la clase controller, entendemos que no es lo mejor por lo que hubieramos querido levantar dicha parametría de un json y cargarlo en un diccionario para poder acceder a el. Por esta misma razon la FrencuenciaDeRecurrencia no se esta utilizando y actualmente es codigo muerto.</li>
<li>6- Los diagramas quedaron desactualizados debido a los cambios de ultimo ingresados de ultimo momento</li>
