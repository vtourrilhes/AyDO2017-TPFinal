
___
#Integrantes TP Final Ruby parte 2:
___
* Walter Davalos
* Valentin Tourrilhes
___
#Problemas solucionados de la version recibida
___

* El calendario borrado ya se borra sin importar o no la aplicacion sea reinicializada. 
* Se soluciono la actualizacion de recurrencia. 

___
#Link a travis

https://travis-ci.org/vtourrilhes/AyDO2017-TPFinal
___

___
# Para testear mediante curl las nuevas funcionalidades pedidas
___ 

#CREO CALENDARIO Y RECURSO SALA VALIDOS
curl -X POST -d '{"nombre":"calendario1"}' localhost:4567/calendarios   
curl -X POST -d '{"nombre":"sala1","tipo":"sala"}' localhost:4567/recursos
#CREO RECURSOS NO VALIDOS
curl -X POST -d '{"nombre":"choza","tipo":"choza"}' localhost:4567/recursos
curl -X POST -d '{"nombre":"proyector1","tipo":"proyector","estado":"gaseoso"}' localhost:4567/recursos
#CREO UN PROYECTOR SIN ESTADO, DEBERIA CREARSE FUNCIONAL
curl -X POST -d '{"nombre":"proyector1","tipo":"proyector"}' localhost:4567/recursos
#CREO UN PROYECTOR CON ESTADO EN REPARACION
curl -X POST -d '{"nombre":"proyector2","tipo":"proyector","estado":"en reparacion"}' localhost:4567/recursos

#SOLO DEBERIA HABER CREADO sala1, proyector1 y proyector2
curl localhost:4567/recursos

#ASIGNO UN RECURSO INEXISTENTE AL NUEVO EVENTO
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento1", "nombre":"evento uno", "inicio": "2017-07-31T10:00:00-03:00","fin": "2017-07-31T11:00:00-03:00","recurso":{"nombre":"sala20"}}' localhost:4567/eventos

#ASIGNO UNA PROYECTOR VALIDO PERO CON MAS DE 4 HORAS DE DURACION
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento1", "nombre":"evento uno", "inicio": "2017-07-31T10:00:00-03:00","fin": "2017-07-31T16:00:00-03:00","recurso":{"nombre":"proyector1","tipo":"proyector","estado":"funcional"}}' localhost:4567/eventos

#ASIGNO UNA PROYECTOR PERO EN REPARACION
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento1", "nombre":"evento uno", "inicio": "2017-07-31T10:00:00-03:00","fin": "2017-07-31T12:00:00-03:00","recurso":{"nombre":"proyector2"}}' localhost:4567/eventos

#ASIGNO UN RECURSO INEXISTENTE AL NUEVO RECURSO
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento1", "nombre":"evento uno", "inicio": "2017-07-31T10:00:00-03:00","fin": "2017-07-31T11:00:00-03:00","recurso":{"nombre":"sala100"}}' localhost:4567/eventos

#ASIGNO UNA SALA PERO CON RECURRENCIA MAYOR A 30 DIAS
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento1", "nombre":"evento uno", "inicio": "2017-07-31T10:00:00-03:00","fin": "2017-07-31T11:00:00-03:00","recurrencia":{"frecuencia":"diaria","fin":"2017-09-28T12:00:00-03:00"},"recurso":{"nombre":"sala1"}}' localhost:4567/eventos

#CREO UN EVENTO CON UNA SALA
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento10", "nombre":"evento diez", "inicio": "2017-07-31T10:00:00-03:00","fin": "2017-07-31T11:00:00-03:00","recurso":{"nombre":"sala1"}}' localhost:4567/eventos

#SOLO DEBERIA HABER UN EVENTO CREADO (evento10)
curl localhost:4567/eventos

#NO DEBERIA MODIFICAR NADA
curl -X PUT -d '{ "id":"evento10"}' localhost:4567/eventos
curl localhost:4567/eventos

#MODIFICO FECHA DE INICIO Y AGREGO RECURRENCIA
curl -X PUT -d '{ "id":"evento10", "inicio": "2017-07-31T09:11:00-03:00","recurso":{"nombre":"sala1"},"recurrencia": {"frecuencia": "diaria","fin":"2017-08-05"}}' localhost:4567/eventos
curl localhost:4567/eventos

#MODIFICO LA RECURRENCIA
curl -X PUT -d '{ "id":"evento10", "fin": "2017-07-31T10:30:00-03:00","recurso":{"nombre":"sala1"},"recurrencia": {"frecuencia": "semanal","fin":"2017-08-20"}}' localhost:4567/eventos
curl localhost:4567/eventos

#MODIFICO EL RECURSO
curl -X PUT -d '{ "id":"evento10","recurso":{"nombre":"proyector1"},"recurrencia": {"frecuencia": "semanal","fin":"2017-08-20"}}' localhost:4567/eventos
curl localhost:4567/eventos


#NO DEBERIA MODIFICAR NADA
curl -X PUT -d '{ "id":"evento10"}' localhost:4567/eventos
curl localhost:4567/eventos


#BORRO LOS RECURSOS
curl -X DELETE localhost:4567/recursos/sala1
curl -X DELETE localhost:4567/recursos/proyector1
curl -X DELETE localhost:4567/recursos/proyector2


#CHEQUEO QUE LOS RECURSOS DEL EVENTO QUEDARON NULOS
curl localhost:4567/eventos

#BORRO EL EVENTO
curl -X DELETE localhost:4567/eventos/evento10

#BORRO EL CALENDARIO
curl -X DELETE localhost:4567/calendarios/calendario1

