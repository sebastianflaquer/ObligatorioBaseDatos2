

-- a. No permitir registrar un administrador de grupo si el usuario no es un participante del grupo.

-- b. Cuando se realice un DELETE sobre la tabla usuario, el o los usuarios afectados por el DELETE efectivamente
-- se elimine/n de la base de datos (eliminar de las tablas que lo referencian).

-- c. Cuando se crea un chat, agregar autom�ticamente como participante al usuario creador del chat.

-- d. No permitir que haya m�s de 2 participantes de un chat si el chat no es grupal.

-- e. Cuando se registre la fecha de fin de una llamada, registrar la duraci�n de la misma.

-- f. Crear un trigger que registre en un log cada vez que se elimina un mensaje (se deben persistir todos los datos
-- originales del mensaje, as� como tambi�n la fecha de eliminaci�n). Implementar la estructura necesaria para
-- soportar este trigger.