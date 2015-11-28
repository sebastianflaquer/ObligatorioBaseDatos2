

-- LISTO a. No permitir registrar un administrador de grupo si el usuario no es un participante del grupo.

create trigger nopermiteregistroadmin
on GrupoAdmin
instead of insert 
as
begin

insert grupoAdmin 
	select i.chatId, usuarioParticipante
	from inserted i, chatParticipante cp 
	where i.chatId = cp.chatId
	and i.usuarioId IN (select usuarioParticipante from chatParticipante)
end

insert into grupoAdmin values (1,3) 

select * from grupoAdmin
select * from chatParticipante

-- LITSO - b. Cuando se realice un DELETE sobre la tabla usuario, el o los usuarios afectados por el DELETE efectivamente
---------- se elimine/n de la base de datos (eliminar de las tablas que lo referencian).

create trigger tr_ejer_b
on usuario
instead of delete
as
begin

delete from bloqueado
where usuarioId in (select deleted.usuarioId from deleted)
OR contactoBloqueadoId in (select deleted.usuarioId from deleted)

delete from contacto
where usuarioId in (select deleted.usuarioId from deleted)
or contactoId in (select deleted.usuarioId from deleted)

delete from llamada
where llamador in (select deleted.usuarioId from deleted)
or receptor in (select deleted.usuarioId from deleted)

delete from mensaje
where usuarioId in (select deleted.usuarioId from deleted)

delete from grupoAdmin
where usuarioId in (select deleted.usuarioId from deleted)

delete from chatParticipante
where usuarioParticipante in (select deleted.usuarioId from deleted)

delete from chat
where usuarioCreador in (select deleted.usuarioId from deleted)

delete from usuario
where usuarioId in (select deleted.usuarioId from deleted)

end


insert into usuario (usuarioTelefono, usuarioNombre, usuarioUltimaActividad, usuarioEstado, paisId) values
	('2','Carlos Montero','2012-10-23 20:44:11','En el Gimnasio','BEL')

insert into bloqueado values
	(44, 17, '2012-02-05T01:27:12')

insert into contacto values
	(44, 19)

insert into llamada values
	(44, 7, '2012-02-05T01:27:12', '2012-02-05T01:29:12', 2, 0),
	(7, 44, '2012-02-05T01:27:12', '2012-02-05T01:29:12', 2, 0)

insert into mensaje values
	(33, 7, 44, '2012-01-05T01:27:12', 'Texto', 'Pendiente', 'Contenido del Mensaje', 35)


insert into grupoAdmin values
	(1, 44)

insert into chatParticipante values
	(1, 44)

insert into chat values
	(44,'2014-01-24T12:32:01', 0, 41)

select *
from usuario

select *
from bloqueado

select *
from grupoAdmin

delete from usuario
where usuarioId = 44

select *
from usuario

-- LISTO c. Cuando se crea un chat, agregar automáticamente como participante al usuario creador del chat.

create trigger tr_ejer_C
on chat
after insert
as
begin

insert into chatParticipante 
select chatId, usuarioCreador
from inserted

end

insert into chat values
	(2,'2014-01-24T12:32:01', 0, 42)

select *
from chat

select *
from chatParticipante


-- LISTO d. No permitir que haya más de 2 participantes de un chat si el chat no es grupal.

alter trigger tr_ejer_d
on chatParticipante 
instead of insert 
as
begin

insert chatParticipante
select i.chatId, i.usuarioParticipante	
	from inserted i, chat ch
	where ch.chatId = i.chatId
	AND ch.esGrupo = 1	
	or (ch.esGrupo = 0 
		and 2 < (select count(chatId)
				from chatParticipante ch
				where ch.chatId = i.chatId)
end


insert into chatParticipante values
	(1, 7)
	

select i.chatId, i.usuarioParticipante	
	from inserted i, chat ch
	where ch.chatId = i.chatId
	AND ch.esGrupo = 'TRUE'
	or 2 < (select count(chatId)
				from chatParticipante ch
				where ch.chatId = 1)

insert chatParticipante values (19, 2)

insert into chatParticipante values
	(1,8)

select *
from chatParticipante

select *
from chat

SELECT *
FROM usuario


-- FALTA e. Cuando se registre la fecha de fin de una llamada, registrar la duración de la misma.

alter trigger tr_ejer_e
on llamada
after insert
as
begin	
	UPDATE llamada
	SET duracion = datediff(SECOND, CAST(inserted.fechaComienzo as datetime), CAST(inserted.fechaFin as datetime))
	from inserted, llamada
	where llamada.llamador = inserted.llamador 
	AND llamada.receptor = inserted.receptor
	AND llamada.fechaComienzo = inserted.fechaComienzo
end

insert into llamada values
	(2, 10, '2015-02-05T01:27:12', '2015-02-05T01:28:12', null, 0)

select datediff(SECOND, CAST('2015-02-05T01:27:12' as datetime) , CAST('2015-02-05T01:28:12' as datetime))
					from inserted

select *
from llamada

select * 
from usuario

-- LISTO - f. Crear un trigger que registre en un log cada vez que se elimina un mensaje (se deben persistir todos los datos
---------- originales del mensaje, así como también la fecha de eliminación). Implementar la estructura necesaria para
---------- soportar este trigger.

create table logmensage (
	mensajeId int,
	chatId int,
	usuarioId int,
	fechaMensaje datetime,
	mensajeTipo varchar(6),
	mensajeEstado varchar(10),
	mensajeTexto varchar(1000),
	archivoId int,
	fechaEliminacion datetime
)

create trigger tr_ejer_f
on mensaje
after delete
as
begin
	insert logmensage
	select *, GETDATE()
	from deleted
end

select *
from mensaje

DELETE FROM mensaje
WHERE mensajeId=5;

SELECT *
FROM logmensage