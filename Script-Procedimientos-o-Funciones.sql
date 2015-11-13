
-- a. Crear un procedimiento almacenado 'infoChat' que reciba como par�metros el identificador de un chat, y devuelva
-- por par�metros: la cantidad de usuarios del chat, la fecha de creaci�n del chat, la cantidad de mensajes enviados al
-- chat, la cantidad de archivos del chat y la cantidad de administradores del chat.

-- b. Crear un procedimiento almacenado 'datosUsuario', que dado el c�digo de un usuario, devuelva por par�metro: la cantidad
-- de chats en los que participa, la cantidad de mensajes generados, la cantidad de contactos que tiene, la cantidad de llamadas
-- realizadas y la cantidad de usuarios que lo han bloqueado.

-- c. Implementar una funci�n 'cantUsuariosMensajeFecha', que reciba como par�metros el id de un chat y un rango de fechas,
-- devolviendo la cantidad de usuarios distintos que generaron mensajes en el chat durante el per�odo recibido como par�metro.

-- d. Implementar una procedimiento almacenado 'crearLlamada', que reciba como par�metros el id del usuario llamador, el id
-- del usuario receptor y registre la llamada con la fecha actual en la tabla llamada.

-- e. Crear una funci�n 'llamadasMensajes', que reciba una fecha y devuelva la cantidad de usuarios que en dicha fecha
-- realizaron m�s llamadas que la cantidad de mensajes que escribieron en la fecha.

-- f. Crear un procedimiento almacenado 'usuariosPais' que dado el c�digo de un pa�s, devuelva por par�metro: el nombre
-- del pa�s, la cantidad de usuarios que tiene, la cantidad de usuarios bloqueados al menos por un usuario y la cantidad
-- de usuarios sin bloquear.

-- g. Crear una funci�n 'usuarioMasMensajesTextoAnio' que reciba como par�metro un a�o y devuelva el id del usuario
-- que escribi� m�s mensajes del tipo texto en el a�o.