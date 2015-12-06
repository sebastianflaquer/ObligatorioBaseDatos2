
-- LISTO a. No permitir registrar un administrador de grupo si el usuario no es un participante del grupo.

create trigger tr_ejer_a
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

-- LISTO d. No permitir que haya más de 2 participantes de un chat si el chat no es grupal.

create trigger tr_ejer_d
on chatParticipante 
instead of insert 
as
begin

insert chatParticipante
select i.chatId, i.usuarioParticipante	
	from inserted i, chat ch
	where ch.chatId = i.chatId
	AND (
			(ch.esGrupo = 1)	
			or (ch.esGrupo = 0
				and 2 > (
						select count(chatId)
						from chatParticipante ch
						)
				)
		)
end


-- FALTA e. Cuando se registre la fecha de fin de una llamada, registrar la duración de la misma.

create trigger tr_ejer_e
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

-- LISTO - f. Crear un trigger que registre en un log cada vez que se elimina un mensaje (se deben persistir todos los datos
---------- originales del mensaje, así como también la fecha de eliminación). Implementar la estructura necesaria para
---------- soportar este trigger.

go
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

go
create trigger tr_ejer_f
on mensaje
after delete
as
begin
	insert logmensage
	select *, GETDATE()
	from deleted
end