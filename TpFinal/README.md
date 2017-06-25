Funcionalidad recursos varios

Los recursos pueden ser Salas o Proyectores. 

Las salas solo pueden reservarse en el horario de 9 a 18 de lunes a viernes. Tampoco pueden reservarse recurrentemente por más 30 días, o sea:

si la recurrencia es diaria entonces no puede haber 31 reservas

si la recurrencia es quincenal, entonces puede haber a sumo 2 reservas

Los proyectores no pueden reservarse por más de 4 horas seguidas. Al mismo tiempo los proyectores tienen un estado que puede ser: funcional o en reparación, cuando están en reparación no pueden reservarse.




 
curl -X POST -d '{"nombre":"calendario1"}' localhost:4567/calendarios 
 
curl localhost:4567/calendarios 
 
curl -X POST  -d '{ "calendario":"calendario1", "id":"evento1", "nombre":"evento uno", "inicio": "2017-07-31T18:00:00-03:00","fin": "2017-07-31T22:00:00-03:00","recurso":"sala1"}' localhost:4567/eventos
 
curl localhost:4567/eventos
 
curl -X PUT -d '{ "id":"evento1", "inicio": "2017-07-31T18:11:00-03:00",  "recurrencia": {"frecuencia": "diaria","fin":"2017-08-05"}}' localhost:4567/eventos
 
curl localhost:4567/eventos
 
curl -X DELETE localhost:4567/eventos/evento1

curl -X DELETE localhost:4567/calendarios/calendario1

