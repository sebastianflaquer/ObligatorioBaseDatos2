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
on grupo Ad


-- b. Cuando se realice un DELETE sobre la tabla usuario, el o los usuarios afectados por el DELETE efectivamente
-- se elimine/n de la base de datos (eliminar de las tablas que lo referencian).

create trigger


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

create trigger


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