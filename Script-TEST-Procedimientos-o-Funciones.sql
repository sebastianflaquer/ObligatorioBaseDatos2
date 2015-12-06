--Test de procedimientos y Funciones


--A

/* testeo */
declare @cantidadUsuarioChat int, @fechaCreacionChat date, @cantidadMEnviadosChat int, @cantidadArchivosChat int, @cantidadAdminChar int
exec infoChat 7, @cantidadUsuarioChat output, @fechaCreacionChat output, @cantidadMEnviadosChat output, @cantidadArchivosChat output, @cantidadAdminChar output
print @cantidadUsuarioChat print @fechaCreacionChat print @cantidadMEnviadosChat print @cantidadArchivosChat print @cantidadAdminChar

--B

/* testeo */
declare @cantidadChatParticipa int, @cantidadMensajesGenerados int, @cantidadContactos int, @cantidadLlamadasRealizadas int, @cantidadUsuariosQueLoBloq int
exec datosUsuario 8, @cantidadChatParticipa output, @cantidadMensajesGenerados output, @cantidadContactos output, @cantidadLlamadasRealizadas output, @cantidadUsuariosQueLoBloq output
print @cantidadChatParticipa print @cantidadMensajesGenerados print @cantidadContactos print @cantidadLlamadasRealizadas print @cantidadUsuariosQueLoBloq


--C

/* testeo */
SELECT [dbo].[cantUsuariosMensajeFecha](7, '2000-01-05T01:27:12.000', '2016-01-05T01:27:12.000') as RESULTADO

--D

/* testeo */
	exec crearLlamada 5, 7

--E

/* testeo */
SELECT [dbo].[llamadasMensajes]('2012-02-05T01:27:12.000') as RESULTADO

/*********************************************************************** pruebas */
select count(m.usuarioId)
from mensaje m
where m.usuarioId = 1
AND CAST(m.fechaMensaje as DATE) = '2012-02-05'

select count(*)
from llamada ll
where ll.llamador = 1
AND CAST(ll.fechaComienzo as DATE) = '2012-02-05'

select COUNT(distinct ll.llamador)
from llamada ll
where CAST(ll.fechaComienzo as DATE) = CAST('2012-02-05T01:27:12.000' as DATE)
AND 0 > (select count(m.mensajeId)
			from mensaje m
			where m.fechaMensaje = '2012-02-05T01:27:12.000')

select *
from mensaje

select *
from llamada

/*********************************************************************** pruebas */


--F

/* testeo */
declare @paisNombre varchar(50), @cantidadUsuario int, @cantidadUsuariosBloq int, @cantidadUsuariosSinBloq int
exec usuariosPais 'URY', @paisNombre output, @cantidadUsuario output, @cantidadUsuariosBloq output, @cantidadUsuariosSinBloq output
print @paisNombre print @cantidadUsuario print @cantidadUsuariosBloq print @cantidadUsuariosSinBloq



--G

--H

--I

--J

--K