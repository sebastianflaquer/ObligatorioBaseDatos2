-- LISTO--a. Mostrar el/los id de chat creado/s por usuarios uruguayos, que tenga m�s archivos.

select m.chatId
from mensaje m, chat c
where m.chatId = c.chatId
and usuarioCreador IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))
group by m.chatId
having COUNT(*)
>=ALL (select count(archivoId) from mensaje m, chat c
			where m.chatId = c.chatId
			and usuarioCreador IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))
			group by m.chatId)


/* para lipiar el ident */
---dbcc checkident ('nom_tabla', reseed, valor (tiene que ser un entero))



--LISTO--b. Mostrar id y tel�fono de los usuarios de Uruguay que son administradores de todos los grupos en los que participa.

select u.usuarioId, u.usuarioTelefono
from usuario u, chatParticipante cp, grupoAdmin g
where u.usuarioId = cp.usuarioParticipante
and cp.usuarioParticipante = g.usuarioId
and cp.chatId IN (select chatId from chat where esGrupo = 1)
and g.usuarioId IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))


--LISTO  -- c. Proporcionar un listado con el id, tel�fono y nombre de cada usuario, conjuntamente con la fecha de �ltima actividad,
----------	 la cantidad de grupos en los que participa y la cantidad de chat no grupales en los que participa.
----------	 En caso de que el usuario no participe en chats, igual deber� aparecer en el resultado de la consulta.


select distinct usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, COUNT(cp.chatId) CantGrupos, COUNT(c.chatId) CanChatNoGrupales
from usuario u left join chat c 
on u.usuarioId = c.usuarioCreador
 left join chatParticipante cp
on  u.usuarioId = cp.usuarioParticipante
group by  usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, cp.chatId, c.chatId


-- FALTA -- d. Realizar una consulta que devuelva para cada usuario (id de usuario) el id del chat de grupo con m�s usuarios al que 
-- pertenece. En caso de que haya m�s de un grupo con la m�xima cantidad, deben aparecer todos en el resultado de la 
-- consulta (id usuario, id chat). En caso de que haya usuarios que no participen en grupos, tambi�n deber�n aparecer 
-- en el resultado de la consulta.

select u.usuarioId, c.chatId
from usuario u left join chat c
on u.usuarioId = c.usuarioCreador
left join chatParticipante cp
on u.usuarioId = cp.usuarioParticipante
group by u.usuarioId, c.chatId
having count(usuarioParticipante) >= All (
						select count(usuarioParticipante) suma
						from chatParticipante cp
						group by (chatId)
						)


-- FALTA -- e. Mostrar los datos de los usuarios que no sean administradores de grupos, que participen en m�s de 4 grupos y que hayan
-- sido bloqueados por m�s usuarios que la cantidad de contactos que tiene.

	select u.*
	from usuario u, contacto c, bloqueado b
	where u.usuarioId = c.usuarioId
	and b.usuarioId = u.usuarioId
	and u.usuarioId NOT IN (select usuarioId from grupoAdmin)
	and u.usuarioId IN (select usuarioParticipante
						from chatParticipante
						group by usuarioParticipante
						HAVING COUNT(chatId) > 4)
	and (select count(contactoId) from contacto where usuarioId = 10)
	< (select count(usuarioId) from bloqueado where contactoBloqueadoId = 10)




	and(
	select count(contactoId) 
	from contacto 
	where usuarioId = 10
	)	
	< (select count(usuarioId) from bloqueado where contactoBloqueadoId = 10)

	/* bolaso */

		and u.usuarioId IN (
		select contactoBloqueadoId 
		from bloqueado
		group by contactoBloqueadoId
		having count(contactoBloqueadoId) > (
												select 
												)
	)

-- LISTO -- f. Devolver id y tel�fono de los usuarios que: o no participan de chats grupales, o participan en m�s de 5 chats grupales
-- con m�s de 5 participantes cada uno.

select distinct u.usuarioId, u.usuarioTelefono
from usuario u
where u.usuarioId Not In(select cp.usuarioParticipante 
						 from chatParticipante cp, chat c
						 where cp.chatId = c.chatId
						 AND c.esGrupo = 1)

OR u.usuarioId in( select usuarioParticipante
				   from chatParticipante cp2, chat c2
				   where cp2.chatId = c2.chatId
				   and c2.esGrupo = 1
				   and c2.chatId in (
									 select chatId
									 from chatParticipante
									 group by chatId
									 having count(usuarioParticipante) > 5
									)
				   group by usuarioParticipante
				   HAVING COUNT(c2.chatId) > 5
				   )

-- falta, raro la letra --g. Devolver id y nombre de los pa�ses con m�s de 3 chats que solo tengan participantes del pa�s.

select p.paisId, p.paisNombre
from pais p
where paisId IN (select distinct paisId
						 from usuario 
						 where usuarioId IN (select usuarioCreador 
											 from chat))

and paisId IN (select paisId  from usuario 
					where usuarioId IN ())


and 3 < (select count(chatId) from chatParticipante
				group by usuarioParticipante)




-- Listo pero AMBIGUO -- h. Devolver id y tel�fono de los usuarios que a la fecha hayan generado m�s mensajes de audio que la cantidad total de
-- mensajes generados el a�o pasado.

select distinct u.usuarioId, u.usuarioTelefono
from usuario u, mensaje m
where u.usuarioId = m.usuarioId
and u.usuarioId in(
					select usuarioId
					from mensaje m
					where m.mensajeTipo = 'Audio'
					group by usuarioId
					having count(m.mensajeId) > (
													select count(*)
													from mensaje m
													where year(m.fechaMensaje) = YEAR(GETDATE()-1)
												 )
)

-- i. Devolver para cada pa�s el promedio de contactos por usuario.

select p.paisId, (
					(select count(contactoId) from contacto)
					/(select count(distinct c.usuarioId) from contacto c)
				 )
from pais p
group by (paisId)

select count(contactoId)
from contacto c, usuario u


-------------------------------------------------

select p.paisId, (c.contactoId) AS Contacto
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


-- j. Mostrar los datos de los chats grupales que tengan a m�s de la mitad de sus participantes como administradores.


/* la paso denise */
select cp.chatId, c.usuarioCreador, c.chatFechaCreacion, c.esGrupo
from chatParticipante cp, chat c, grupoAdmin ga
where cp.chatId = c.chatId
AND cp.chatId = ga.chatId
AND c.esGrupo = 1
group by cp.chatId, c.usuarioCreador, c.chatFechaCreacion, c.esGrupo
having count(ga.usuarioId)>(select count(cp2.usuarioParticipante)/2 from chatParticipante cp2 where cp2.chatId = cp.chatId)
/* la paso denise */


-- k. Devolver para cada usuario la cantidad total de segundos hablados, considerandos solamente los usuarios que hayan sido
-- receptores de llamadas de m�s de 3 usuarios distintos de al menos 10 segundos de duraci�n y que no tengan m�s de 10
-- llamadas sin responder.



--l. Devolver id de los chats grupales con m�s de 10 participantes, que no tengan participantes que est�n bloqueados por
-- alg�n usuario.