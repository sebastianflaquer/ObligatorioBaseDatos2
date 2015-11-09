--a. Mostrar el/los id de chat creado/s por usuarios uruguayos, que tenga m�s archivos.

select m.chatId
from mensaje m, chat c
where m.chatId = c.chatId
and usuarioCreador IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))
group by m.chatId
having COUNT(*)
>=ALL (select count(*) from archivo group by archivoId)


-- SEGUNDA OPCION
select m.chatID
from mensaje m, chat c
where m.chatId = c.chatId
AND usuarioCreador IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))
group by m.chatId
having COUNT(*)
>= ALL (select chatId, COUNT (archivoId) from mensaje group by chatId)





--b. Mostrar id y tel�fono de los usuarios de Uruguay que son administradores de todos los grupos en los que participa.

select u.usuarioId, u.usuarioTelefono
from usuario u, chatParticipante cp, grupoAdmin g
where u.usuarioId = cp.usuarioParticipante
and cp.usuarioParticipante = g.usuarioId
and cp.chatId IN (select chatId from chat where esGrupo = 1)
and g.usuarioId IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))




--c. Proporcionar un listado con el id, tel�fono y nombre de cada usuario, conjuntamente con la fecha de �ltima actividad,
--	 la cantidad de grupos en los que participa y la cantidad de chat no grupales en los que participa.
--	 En caso de que el usuario no participe en chats, igual deber� aparecer en el resultado de la consulta.


select usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, count(chatId)
from usuario u, chat c






--d. Realizar una consulta que devuelva para cada usuario (id de usuario) el id del chat de grupo con m�s usuarios al que pertenece. En caso de que haya m�s de un grupo con la m�xima cantidad, deben aparecer todos en el resultado de la consulta (id usuario, id chat). En caso de que haya usuarios que no participen en grupos, tambi�n deber�n aparecer en el resultado de la consulta.
--e. Mostrar los datos de los usuarios que no sean administradores de grupos, que participen en m�s de 4 grupos y que hayan sido bloqueados por m�s usuarios que la cantidad de contactos que tiene.
--f. Devolver id y tel�fono de los usuarios que: o no participan de chats grupales, o participan en m�s de 5 chats grupales con m�s de 5 participantes cada uno.
--g. Devolver id y nombre de los pa�ses con m�s de 3 chats que solo tengan participantes del pa�s.
--h. Devolver id y tel�fono de los usuarios que a la fecha hayan generado m�s mensajes de audio que la cantidad total de mensajes generados el a�o pasado.
--i. Devolver para cada pa�s el promedio de contactos por usuario.
--j. Mostrar los datos de los chats grupales que tengan a m�s de la mitad de sus participantes como administradores.
--k. Devolver para cada usuario la cantidad total de segundos hablados, considerandos solamente los usuarios que hayan sido receptores de llamadas de m�s de 3 usuarios distintos de al menos 10 segundos de duraci�n y que no tengan m�s de 10 llamadas sin responder.
--l. Devolver id de los chats grupales con m�s de 10 participantes, que no tengan participantes que est�n bloqueados por alg�n usuario.