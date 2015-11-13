
-- a. Crear un procedimiento almacenado 'infoChat' que reciba como parámetros el identificador de un chat, y devuelva
-- por parámetros: la cantidad de usuarios del chat, la fecha de creación del chat, la cantidad de mensajes enviados al
-- chat, la cantidad de archivos del chat y la cantidad de administradores del chat.

-- b. Crear un procedimiento almacenado 'datosUsuario', que dado el código de un usuario, devuelva por parámetro: la cantidad
-- de chats en los que participa, la cantidad de mensajes generados, la cantidad de contactos que tiene, la cantidad de llamadas
-- realizadas y la cantidad de usuarios que lo han bloqueado.

-- c. Implementar una función 'cantUsuariosMensajeFecha', que reciba como parámetros el id de un chat y un rango de fechas,
-- devolviendo la cantidad de usuarios distintos que generaron mensajes en el chat durante el período recibido como parámetro.

-- d. Implementar una procedimiento almacenado 'crearLlamada', que reciba como parámetros el id del usuario llamador, el id
-- del usuario receptor y registre la llamada con la fecha actual en la tabla llamada.

-- e. Crear una función 'llamadasMensajes', que reciba una fecha y devuelva la cantidad de usuarios que en dicha fecha
-- realizaron más llamadas que la cantidad de mensajes que escribieron en la fecha.

-- f. Crear un procedimiento almacenado 'usuariosPais' que dado el código de un país, devuelva por parámetro: el nombre
-- del país, la cantidad de usuarios que tiene, la cantidad de usuarios bloqueados al menos por un usuario y la cantidad
-- de usuarios sin bloquear.

-- g. Crear una función 'usuarioMasMensajesTextoAnio' que reciba como parámetro un año y devuelva el id del usuario
-- que escribió más mensajes del tipo texto en el año.