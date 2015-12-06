-- LISTO--a. Mostrar el/los id de chat creado/s por usuarios uruguayos, que tenga más archivos.

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



--LISTO--b. Mostrar id y teléfono de los usuarios de Uruguay que son administradores de todos los grupos en los que participa.

select u.usuarioId, u.usuarioTelefono
from usuario u, chatParticipante cp, grupoAdmin g
where u.usuarioId = cp.usuarioParticipante
and cp.usuarioParticipante = g.usuarioId
and cp.chatId IN (select chatId from chat where esGrupo = 1)
and g.usuarioId IN (select usuarioId from usuario where paisId = (select paisId from pais where paisNombre = 'Uruguay'))


--LISTO  -- c. Proporcionar un listado con el id, teléfono y nombre de cada usuario, conjuntamente con la fecha de última actividad,
----------	 la cantidad de grupos en los que participa y la cantidad de chat no grupales en los que participa.
----------	 En caso de que el usuario no participe en chats, igual deberá aparecer en el resultado de la consulta.


select distinct usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, COUNT(cp.chatId) CantGrupos, COUNT(c.chatId) CanChatNoGrupales
from usuario u left join chat c 
on u.usuarioId = c.usuarioCreador
 left join chatParticipante cp
on  u.usuarioId = cp.usuarioParticipante
group by  usuarioId, usuarioTelefono, usuarioNombre, usuarioUltimaActividad, cp.chatId, c.chatId


-- FALTA -- d. Realizar una consulta que devuelva para cada usuario (id de usuario) el id del chat de grupo con más usuarios al que 
-- pertenece. En caso de que haya más de un grupo con la máxima cantidad, deben aparecer todos en el resultado de la 
-- consulta (id usuario, id chat). En caso de que haya usuarios que no participen en grupos, también deberán aparecer 
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


-- LISTO -- e. Mostrar los datos de los usuarios que no sean administradores de grupos, que participen en más de 4 grupos y que hayan
-- sido bloqueados por más usuarios que la cantidad de contactos que tiene.

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



	
-- LISTO -- f. Devolver id y teléfono de los usuarios que: o no participan de chats grupales, o participan en más de 5 chats grupales
-- con más de 5 participantes cada uno.

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

-- LISTO --g. Devolver id y nombre de los países con más de 3 chats que solo tengan participantes del país.

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
 
-- LISTO -- h. Devolver id y teléfono de los usuarios que a la fecha hayan generado más mensajes de audio que la cantidad total de
-- mensajes generados el año pasado.

select distinct u.usuarioId, u.usuarioTelefono
from usuario u
join mensaje m on m.usuarioId = u.usuarioId
where m.mensajeTipo = 'Audio'
group by u.usuarioId, u.usuarioTelefono
having count(*) > (select count(*) from mensaje m2 where m2.usuarioId = u.usuarioId and year(m2.fechaMensaje) = year(getdate()-1) )



-- LISTO -- i. Devolver para cada país el promedio de contactos por usuario.

select p.paisId, p.paisNombre, (select count(*) 
								from usuario u2 join contacto c 
								on c.usuarioId = u2.usuarioId 
								where u2.paisId = p.paisId)/nullif((select count(*) 
																	from usuario u 
																	where u.paisId = p.paisId),0)
from pais p



--REVISAR-- j. Mostrar los datos de los chats grupales que tengan a más de la mitad de sus participantes como administradores.


select c.*	
from chat c
where esGrupo = 1
and ((select count(*) from chatParticipante c3 where c3.chatId = c.chatId) / 2) 
	< (select count(*) from grupoAdmin g2 where g2.chatId = c.chatId)




--REVISAR-- k. Devolver para cada usuario la cantidad total de segundos hablados, considerandos solamente los usuarios que hayan sido
-- receptores de llamadas de más de 3 usuarios distintos de al menos 10 segundos de duración y que no tengan más de 10
-- llamadas sin responder.


select u.usuarioId, SUM(l.duracion) totalHablado
from usuario u, llamada l
where u.usuarioId = l.llamador
and usuarioId IN (select receptor from llamada
					where 3 < (select count(distinct llamador) from llamada l2 where l2.receptor = l.llamador and duracion >= 10)
					and 10 > (select count(*) from llamada l3 where l3.receptor = l.llamador and respondida = 0))
group by u.usuarioId


	

--A MEDIA--l. Devolver id de los chats grupales con más de 10 participantes, que no tengan participantes que estén bloqueados por
-- algún usuario.

select chatId
from chat
where chatId IN (select chatId from chatParticipante c3 
								where c3.chatId = chat.chatId
								group by usuarioParticipante
							    having count(*) > 10)