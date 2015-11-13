--a. Mostrar el/los id de chat creado/s por usuarios uruguayos, que tenga más archivos.

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

/* para lipiar el ident */
dbcc checkident ('nom_tabla', reseed, valor (tiene que ser un entero))



--b. Mostrar id y teléfono de los usuarios de Uruguay que son administradores de todos los grupos en los que participa.

select u.usuarioId, u.usuarioTelefono
from usuario u, chatParticipante cp, grupoAdmin g
where u.usuarioId = cp.usuarioParticipante
and cp.usuarioParticipante = g.usuarioId
and cp.chatId IN (select chatId from chat where esGrupo = 1)
and g.usuarioId IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))



--c. Proporcionar un listado con el id, teléfono y nombre de cada usuario, conjuntamente con la fecha de última actividad,
--	 la cantidad de grupos en los que participa y la cantidad de chat no grupales en los que participa.
--	 En caso de que el usuario no participe en chats, igual deberá aparecer en el resultado de la consulta.


select distinct usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, COUNT(cp.chatId) CantGrupos, COUNT(c.chatId) CanChatNoGrupales
from usuario u, chat c, chatParticipante cp
where u.usuarioId = cp.usuarioParticipante
and cp.chatId = c.chatId
group by  usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, cp.chatId, c.chatId


select distinct usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad
from usuario u


select usuarioId, COUNT(chatId)
from usuario u, chat c
where u.usuarioId = c.usuarioCreador



-- d. Realizar una consulta que devuelva para cada usuario (id de usuario) el id del chat de grupo con más usuarios al que 
-- pertenece. En caso de que haya más de un grupo con la máxima cantidad, deben aparecer todos en el resultado de la 
-- consulta (id usuario, id chat). En caso de que haya usuarios que no participen en grupos, también deberán aparecer 
-- en el resultado de la consulta.


-- e. Mostrar los datos de los usuarios que no sean administradores de grupos, que participen en más de 4 grupos y que hayan
-- sido bloqueados por más usuarios que la cantidad de contactos que tiene.


-- f. Devolver id y teléfono de los usuarios que: o no participan de chats grupales, o participan en más de 5 chats grupales
-- con más de 5 participantes cada uno.


--g. Devolver id y nombre de los países con más de 3 chats que solo tengan participantes del país.
select p.paisId, p.paisNombre
from pais p, usuario u, chat c
where p.paisId = u.paisId
and c.usuarioCreador = u.usuarioId

select p.paisId
from pais p, chat c
where p.paisId = 


-- h. Devolver id y teléfono de los usuarios que a la fecha hayan generado más mensajes de audio que la cantidad total de
-- mensajes generados el año pasado.

select u.usuarioId, u.usuarioTelefono
from usuario u, mensaje m


select *
from mensaje m
where m.fechaMensaje = YEAR(GETDATE()-1)


-- i. Devolver para cada país el promedio de contactos por usuario.

select p.paisId, AVG(c.contactoId) AS Contacto
from pais p, usuario u, contacto c
where p.paisId = u.paisId
and u.usuarioId = c.contactoId
GROUP BY p.paisId

select *
from usuario

select *
from contacto

select c.usuarioId, p.paisId, COUNT(c.usuarioId)
from contacto c, pais p, usuario u
where c.usuarioId = u.usuarioId
and p.paisId = u.paisId
and u.usuarioId = c.usuarioId
group by c.usuarioId, p.paisId


-- j. Mostrar los datos de los chats grupales que tengan a más de la mitad de sus participantes como administradores.


-- k. Devolver para cada usuario la cantidad total de segundos hablados, considerandos solamente los usuarios que hayan sido
-- receptores de llamadas de más de 3 usuarios distintos de al menos 10 segundos de duración y que no tengan más de 10
-- llamadas sin responder.


--l. Devolver id de los chats grupales con más de 10 participantes, que no tengan participantes que estén bloqueados por
-- algún usuario.