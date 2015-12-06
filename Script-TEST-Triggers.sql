
--Test y consultas de triggers

---------------------------------------A
insert into grupoAdmin values (1,3) 

select * from grupoAdmin
select * from chatParticipante


---------------------------------------B

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


---------------------------------------C

insert into chat values
	(2,'2014-01-24T12:32:01', 0, 42)

select *
from chat

select *
from chatParticipante



---------------------------------------D

insert into chatParticipante values	
(1, 6)

select *
from chat
where chatid = 1

DELETE FROM CHATPARTICIPANTE WHERE CHATID = 1

select *
from chatParticipante
where chatid = 1


select i.chatId, i.usuarioParticipante	
	from inserted i, chat ch
	where ch.chatId = i.chatId
	AND ch.esGrupo = 'TRUE'
	or (2 < (select count(chatId)
				from chatParticipante ch
				where ch.chatId = 1))

insert chatParticipante values (19, 2)

insert into chatParticipante values
	(1,8)

select *
from chatParticipante

select *
from chat

SELECT *
FROM usuario


---------------------------------------E

insert into llamada values
	(2, 10, '2015-02-05T01:27:12', '2015-02-05T01:28:12', null, 0)

select datediff(SECOND, CAST('2015-02-05T01:27:12' as datetime) , CAST('2015-02-05T01:28:12' as datetime))
					from inserted

select *
from llamada

select * 
from usuario


---------------------------------------F

select *
from mensaje

DELETE FROM mensaje
WHERE mensajeId=5;

SELECT *
FROM logmensage


---------------------------------------G


---------------------------------------H


---------------------------------------I


---------------------------------------J