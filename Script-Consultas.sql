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

---------------------------------------------------
select  usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, count(distinct c1.chatid) Grupos, COUNT(distinct c2.chatId) NoGrupos
from 
 usuario u left join
chatParticipante Cp1
on u.usuarioId = cp1.usuarioParticipante 
left join  Chat c1 
on c1.chatId = Cp1.chatId and c1.esGrupo = 1
left join chatParticipante cp2
on cp2.usuarioParticipante = cp1.usuarioParticipante
left join chat c2
on c2.chatId = cp2.chatId and c2.esGrupo = 0
group by  usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad

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


-- LISTO -- e. Mostrar los datos de los usuarios que no sean administradores de grupos, que participen en m�s de 4 grupos y que hayan
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
	and (select count(contactoId) from contacto where usuarioId = u.usuarioId)
	< (select count(usuarioId) from bloqueado where contactoBloqueadoId = u.usuarioId)

select u.usuarioId, u.usuarioTelefono
from usuario u, chat c, chatParticipante ch
where u.usuarioId = ch.usuarioParticipante
AND ch.chatId = c.chatId
AND c.esGrupo = 0
AND u.usuarioId in()


--g. Devolver id y nombre de los pa�ses con m�s de 3 chats que solo tengan participantes del pa�s.

select distinct p.paisId, p.paisNombre
from pais p, usuario u, chatParticipante cp
where p.paisId = u.paisId
and u.usuarioId = cp.usuarioParticipante
and chatId not In (select chatId
						from chatParticipante cp1, usuario u2
						where u2.usuarioId = cp1.usuarioParticipante
						AND u2.paisId <> p.paisId
						and cp1.chatId = cp.chatId)
	
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

-- LISTO --g. Devolver id y nombre de los pa�ses con m�s de 3 chats que solo tengan participantes del pa�s.

select p.paisId, p.paisNombre
from pais p
where 3 < (select count(*)
		   from chat c
		   where not exists(select 1
							from chatParticipante cp
							join usuario u on u.usuarioId = cp.usuarioParticipante
							where cp.chatId = c.chatId and u.paisId != p.paisId
							) 
				and exists (select 1
							from chatParticipante cp
							join usuario u on u.usuarioId = cp.usuarioParticipante
							where cp.chatId = c.chatId and u.paisId = p.paisId
							)
		   )
 
-- LISTO -- h. Devolver id y tel�fono de los usuarios que a la fecha hayan generado m�s mensajes de audio que la cantidad total de
-- mensajes generados el a�o pasado.

select distinct u.usuarioId, u.usuarioTelefono
from usuario u
join mensaje m on m.usuarioId = u.usuarioId
where m.mensajeTipo = 'Audio'
group by u.usuarioId, u.usuarioTelefono
having count(*) > (select count(*) from mensaje m2 where m2.usuarioId = u.usuarioId and year(m2.fechaMensaje) = year(getdate()-1) )


-- LISTO -- i. Devolver para cada pa�s el promedio de contactos por usuario.

select p.paisId, p.paisNombre, (select count(*) 
								from usuario u2 join contacto c 
								on c.usuarioId = u2.usuarioId 
								where u2.paisId = p.paisId)/nullif((select count(*) 
																	from usuario u 
																	where u.paisId = p.paisId),0)
from pais p


--REVISAR-- j. Mostrar los datos de los chats grupales que tengan a m�s de la mitad de sus participantes como administradores.

select c.*	
from chat c
where esGrupo = 1
and ((select count(*) from chatParticipante c3 where c3.chatId = c.chatId) / 2) 
	< (select count(*) from grupoAdmin g2 where g2.chatId = c.chatId)


--REVISAR-- k. Devolver para cada usuario la cantidad total de segundos hablados, considerandos solamente los usuarios que hayan sido
-- receptores de llamadas de m�s de 3 usuarios distintos de al menos 10 segundos de duraci�n y que no tengan m�s de 10
-- llamadas sin responder.


select u.usuarioId, SUM(l.duracion) totalHablado
from usuario u, llamada l
where u.usuarioId = l.llamador
and usuarioId IN (select receptor from llamada
					where 3 < (select count(distinct llamador) from llamada l2 where l2.receptor = l.llamador and duracion >= 10)
					and 10 > (select count(*) from llamada l3 where l3.receptor = l.llamador and respondida = 0))
group by u.usuarioId

--REVISAR--l. Devolver id de los chats grupales con m�s de 10 participantes, que no tengan participantes que est�n bloqueados por
-- alg�n usuario.

select c.chatId
from chat c
where esGrupo = 1 
and c.chatId IN (select c2.chatId from chatParticipante c2 
								where c2.chatId = c.chatId
								group by usuarioParticipante
							    having count(*) > 10)
and c.chatId NOT IN (select c3.chatId from chatParticipante c3
							where c3.usuarioParticipante IN (select b.contactoBloqueadoId 
																from bloqueado b))
