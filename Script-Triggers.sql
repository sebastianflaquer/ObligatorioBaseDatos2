CREATE TRIGGER IngresoEstudiante
ON Estudiantes
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO IngresosEstudiantes(idEstudiante, nomEstudiante, fchINGSistema)
SELECT estudianteCod, nombre, GETDATE()
FROM INSERTED;
END;



-- a. No permitir registrar un administrador de grupo si el usuario no es un participante del grupo.

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
	print 'se agrego admin';
end

insert into grupoAdmin values (13,5) 

select * from grupoAdmin
select * from chatParticipante

-- b. Cuando se realice un DELETE sobre la tabla usuario, el o los usuarios afectados por el DELETE efectivamente
-- se elimine/n de la base de datos (eliminar de las tablas que lo referencian).

alter trigger tr_ejer_b
on usuario
instead of delete
as
begin


delete from bloqueado
where usuarioId = (select deleted.usuarioId from deleted)
OR contactoBloqueadoId = (select deleted.usuarioId from deleted)

delete from contacto
where usuarioId = (select deleted.usuarioId from deleted)
or contactoId = (select deleted.usuarioId from deleted)

delete from llamada
where llamador = (select deleted.usuarioId from deleted)
or receptor = (select deleted.usuarioId from deleted)

delete from mensaje
where usuarioId = (select deleted.usuarioId from deleted)

delete from grupoAdmin
where usuarioId = (select deleted.usuarioId from deleted)

delete from chatParticipante
where usuarioParticipante = (select deleted.usuarioId from deleted)

delete from chat
where usuarioCreador = (select deleted.usuarioId from deleted)

delete from usuario
where usuarioId = (select deleted.usuarioId from deleted)

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


-- c. Cuando se crea un chat, agregar automáticamente como participante al usuario creador del chat.

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
	(2,'2014-01-24T12:32:01', 0, 41)

select *
from chat

select *
from chatParticipante


-- d. No permitir que haya más de 2 participantes de un chat si el chat no es grupal.

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
				where ch.chatId = i.chatId))
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




-- e. Cuando se registre la fecha de fin de una llamada, registrar la duración de la misma.

create trigger tr_ejer_e
on llamada
after insert, update
as
begin

	UPDATE llamada
	SET duracion = 

END

-- f. Crear un trigger que registre en un log cada vez que se elimina un mensaje (se deben persistir todos los datos
-- originales del mensaje, así como también la fecha de eliminación). Implementar la estructura necesaria para
-- soportar este trigger.

create table logmensage (
	mensajeId int,
	chatId int,
	usuarioId int,
	fechaMensaje datetime,
	mensajeTipo varchar(6),
	mensajeEstado varchar(10),
	mensajeTexto varchar(1000),
	archivoId int,
	fechaEliminacion date
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
WHERE mensajeId=3;

SELECT *
FROM logmensage