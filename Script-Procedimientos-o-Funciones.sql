
-- a. Crear un procedimiento almacenado 'infoChat' que reciba como parámetros el identificador de un chat, y devuelva
-- por parámetros: 
-- la cantidad de usuarios del chat, 
-- la fecha de creación del chat, 
-- la cantidad de mensajes enviados al chat,
-- la cantidad de archivos del chat y
-- la cantidad de administradores del chat.

create procedure infoChat
	@chatId int,
	@cantidadUsuarioChat int output,
	@fechaCreacionChat date output,
	@cantidadMEnviadosChat int output,
	@cantidadArchivosChat int output,
	@cantidadAdminChar int output

	as
	begin

	--CANTIDAD USUARIO
	select @cantidadUsuarioChat = COUNT(ch.usuarioParticipante)
	from chatParticipante ch, chat c
	where c.chatId = ch.chatId
	AND c.chatId = @chatId

	--FEHCA CREACION
	select @fechaCreacionChat = c.chatFechaCreacion
	from chat c
	where c.chatId = @chatId

	-- CANTIDAD MENSAJES
	select @cantidadMEnviadosChat = COUNT(m.mensajeId)
	from mensaje m, chat c
	where c.chatId = m.chatId
	AND m.mensajeEstado = 'Enviado'
	AND c.chatId = @chatId

	-- CANTIDAD ARCHIVOS
	select @cantidadArchivosChat = COUNT(m.archivoId)
	from mensaje m, chat c
	where c.chatId = m.chatId
	AND c.chatId = @chatId

	-- CANTIDAD ADMINISTRADORES
	select @cantidadAdminChar = COUNT(g.usuarioId)
	from grupoAdmin g, chat c
	where c.chatId = g.chatId
	AND c.chatId = @chatId
			
	end

	declare @cantidadUsuarioChat int, @fechaCreacionChat date, @cantidadMEnviadosChat int, @cantidadArchivosChat int, @cantidadAdminChar int
	exec infoChat 7, @cantidadUsuarioChat output, @fechaCreacionChat output, @cantidadMEnviadosChat output, @cantidadArchivosChat output, @cantidadAdminChar output
	print @cantidadUsuarioChat print @fechaCreacionChat print @cantidadMEnviadosChat print @cantidadArchivosChat print @cantidadAdminChar


	
-- b. Crear un procedimiento almacenado 'datosUsuario', que dado el código de un usuario, devuelva por parámetro: la cantidad
-- de chats en los que participa, la cantidad de mensajes generados, la cantidad de contactos que tiene, la cantidad de llamadas
-- realizadas y la cantidad de usuarios que lo han bloqueado.

create procedure datosUsuario
	
	@usuarioId int,
	@cantidadChatParticipa int output,
	@cantidadMensajesGenerados int output,
	@cantidadContactos int output,
	@cantidadLlamadasRealizadas int output,
	@cantidadUsuariosQueLoBloq int output

	as
	begin
	
	select @cantidadChatParticipa = COUNT(c.chatId)
	from usuario u, chatParticipante c
	where u.usuarioId = c.usuarioParticipante
	AND u.usuarioId = @usuarioId

	
	select @cantidadMensajesGenerados = COUNT(m.mensajeId)
	from usuario u, mensaje m
	where u.usuarioId = m.usuarioId
	AND u.usuarioId = @usuarioId


	select @cantidadContactos = COUNT(c.contactoId)
	from usuario u, contacto c
	where u.usuarioId = c.usuarioId
	AND u.usuarioId = @usuarioId

	
	select @cantidadLlamadasRealizadas = COUNT(*)
	from usuario u, llamada l
	where u.usuarioId = l.llamador
	AND u.usuarioId = 32


	select @cantidadUsuariosQueLoBloq = COUNT(b.usuarioId)
	from usuario u, bloqueado b
	where u.usuarioId = b.usuarioId
	AND b.contactoBloqueadoId = @usuarioId

	end

	declare @cantidadChatParticipa int, @cantidadMensajesGenerados int, @cantidadContactos int, @cantidadLlamadasRealizadas int, @cantidadUsuariosQueLoBloq int
	exec datosUsuario 8, @cantidadChatParticipa output, @cantidadMensajesGenerados output, @cantidadContactos output, @cantidadLlamadasRealizadas output, @cantidadUsuariosQueLoBloq output
	print @cantidadChatParticipa print @cantidadMensajesGenerados print @cantidadContactos print @cantidadLlamadasRealizadas print @cantidadUsuariosQueLoBloq
	

-- c. Implementar una función 'cantUsuariosMensajeFecha', que reciba como parámetros el id de un chat y un rango de fechas,
-- devolviendo la cantidad de usuarios distintos que generaron mensajes en el chat durante el período recibido como parámetro.

-- d. Implementar una procedimiento almacenado 'crearLlamada', que reciba como parámetros el id del usuario llamador, el id
-- del usuario receptor y registre la llamada con la fecha actual en la tabla llamada.

create procedure crearLlamada
	@llamador int,
	@receptor int

	as
	begin

		insert into llamada values
		(@llamador, @receptor, getdate(), null, null, 0)

	end

exec crearLlamada 5, 7

-- e. Crear una función 'llamadasMensajes', que reciba una fecha y devuelva la cantidad de usuarios que en dicha fecha
-- realizaron más llamadas que la cantidad de mensajes que escribieron en la fecha.

-- f. Crear un procedimiento almacenado 'usuariosPais' que dado el código de un país, devuelva por parámetro: 
-- el nombre del país, 
-- la cantidad de usuarios que tiene, 
-- la cantidad de usuarios bloqueados al menos por un usuario
-- y la cantidad de usuarios sin bloquear.

create procedure usuariosPais
	@paisId char(3),
	@paisNombre varchar(50) output,
	@cantidadUsuario int output,
	@cantidadUsuariosBloq int output,
	@cantidadUsuariosSinBloq int output

	as
	begin
	
	-- PAIS NOMBRE
	select @paisNombre = p.paisNombre
	from pais p
	where p.paisId = @paisId

	-- CANTIDAD USUARIOS QUE TIENE
	select @cantidadUsuario = COUNT(u.usuarioId)
	from usuario u, pais p
	where u.paisId = p.paisId
	and p.paisId = @paisId

	-- CANTIDAD USUARIOS BLOQUEADOS
	select @cantidadUsuariosBloq = COUNT(distinct b.contactoBloqueadoId)
	from bloqueado b, usuario u
	where b.contactoBloqueadoId = u.usuarioId
	and u.paisId = @paisId
	
	-- CANTIDAD USUARIOS SIN BLOQUEAR
	
	SELECT @cantidadUsuariosSinBloq = count(distinct u.usuarioId)
	from usuario u
	where u.paisId = @paisId
	and u.usuarioId not in ( select distinct b.contactoBloqueadoId
							from bloqueado b )
	
	end

	declare @paisNombre varchar(50), @cantidadUsuario int, @cantidadUsuariosBloq int, @cantidadUsuariosSinBloq int
	exec usuariosPais 'URY', @paisNombre output, @cantidadUsuario output, @cantidadUsuariosBloq output, @cantidadUsuariosSinBloq output
	print @paisNombre print @cantidadUsuario print @cantidadUsuariosBloq print @cantidadUsuariosSinBloq


-- g. Crear una función 'usuarioMasMensajesTextoAnio' que reciba como parámetro un año y devuelva el id del usuario
-- que escribió más mensajes del tipo texto en el año.





create procedure sp_cambio_supervisor 
	@codigoProy int,
	@documento varchar(8),
	@mensaje varchar(50) output

	as
	begin


	IF EXISTS ( select * from proyecto where cod_proy = @codigoProy)
	begin
	IF EXISTS ( select * from empleado where nro_doc = @documento)
	begin
		update proyecto
		set supervisor = @documento
		where cod_proy = @codigoProy	
	end
	else
		begin
		set @mensaje = 'No existe documento'
		end
	end
	else
	begin
	set @mensaje = 'No existe proyecto'

	end
	end	

	declare @m1 varchar(50)
	exec sp_cambio_supervisor 103, '44177318', @m1 output
	print @m1	










create procedure sp_empleado 
    @documento varchar(8),
	@nombre varchar(40),
	@direccion varchar(40),
	@depto int,
	@numCobro varchar(8)
  	as
	BEGIN
    IF EXISTS ( select * from empleado where nro_doc = @documento)
	
	BEGIN
	 update empleado
	 set nro_doc = @documento,
	  nom_emp = @nombre,
	  dir_emp = @direccion,
	  cod_depto = @depto,
	  nro_cobro = @numCobro
	END

   ELSE 	
	BEGIN
	insert into empleado
	(nro_doc, nom_emp, dir_emp, cod_depto, Nro_cobro) values
	(@documento, @nombre, @direccion, @depto, @numCobro)
	END
	end


exec sp_empleado '44177308', 'Mauro', 'Rivera 1234', 2, 1891

---------------------------------------------------------------------



CREATE PROCEDURE Update_Empresa	
	@Nombre varchar(30),
	@Telefono varchar(50),
	@Mails varchar(300),
	@Url varchar(50),
	@idEmpresa int

	As BEGIN
	SET NOCOUNT ON

		UPDATE Empresas
		SET Nombre=@Nombre,Telefono=@Telefono, Mails=@Mails, Url=@Url
		WHERE IdEmpresa=@idEmpresa;
		
	END 
	GO

	exec Empresa_Insert 'Juan','123456','hola','holaurl', 7