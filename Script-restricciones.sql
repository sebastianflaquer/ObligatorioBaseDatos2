
--CREATE TABLE pais(
--paisId char(3), 
--paisNombre varchar(50)
--)

go
Alter table pais
alter column paisId char(3) not Null

go
Alter table pais
add Constraint Pk_paisId Primary Key (paisId)

go
Alter table pais
alter column paisNombre varchar(50) not Null


--CREATE TABLE usuario(
--usuarioId int, 
--usuarioTelefono varchar(20), 
--usuarioNombre varchar(40), 
--usuarioUltimaActividad datetime,
--usuarioEstado varchar(30), 
--paisId char(3)
--)

alter table usuario
drop column usuarioId

alter table usuario 
add usuarioId int primary key identity

Alter table usuario
alter column usuarioTelefono varchar(20) not Null

Alter table usuario
alter column paisId char(3) not Null

Alter table usuario
alter column usuarioUltimaActividad varchar(20) not Null

alter table usuario
Add Constraint Un_usuarioTelefono unique (usuarioTelefono)

alter table usuario
Add Constraint fk_paisId foreign Key (paisId) references pais


--CREATE TABLE chat(
--chatId int, 
--usuarioCreador int, 
--chatFechaCreacion datetime, 
--esGrupo bit
--)

alter table chat
drop column chatId

alter table chat 
add chatId int primary key

Alter table chat
alter column usuarioCreador int not Null

Alter table chat
alter column chatFechaCreacion datetime not Null

Alter table chat
alter column esGrupo bit not Null

alter table chat
Add Constraint fk_usuarioCreador foreign Key (usuarioCreador) references usuario(usuarioId)

--CREATE TABLE chatParticipante(
--chatId int, 
--usuarioParticipante int
--)

go
Alter table chatParticipante
alter column chatId int not Null

go
alter table chatParticipante 
alter column usuarioParticipante int not Null

go
Alter table chatParticipante
add Constraint Pk_chatId_usuarioParticipante Primary Key (chatId, usuarioParticipante)

go
alter table chatParticipante
Add Constraint fk_chatId foreign Key (chatId) references chat(chatId)

go
alter table chatParticipante
Add Constraint fk_usuarioParticipante foreign Key (usuarioParticipante) references usuario(usuarioId)

--CREATE TABLE grupoAdmin(
--chatId int, 
--usuarioId int
--)

go
Alter table grupoAdmin
alter column chatId int not Null

go
Alter table grupoAdmin
alter column usuarioId int not Null

go
Alter table grupoAdmin
add Constraint Pk_chatId_usuarioId Primary Key (chatId, usuarioId)

go
alter table grupoAdmin
Add Constraint fk_chatId_grupoAdmin foreign Key (chatId) references chat(chatId)

go
alter table grupoAdmin
Add Constraint fk_usuarioId_grupoAdmin foreign Key (usuarioId) references usuario(usuarioId)

--CREATE TABLE archivo(
--archivoId int, 
--archivoContenido VARBINARY(MAX)
--)

alter table archivo drop column archivoId

alter table archivo 
add archivoId int primary key identity


Alter table archivo
alter column archivoContenido int not Null

--CREATE TABLE mensaje(
--mensajeId int, 
--chatId int, 
--usuarioId int, 
--fechaMensaje datetime, 
--mensajeTipo varchar(6),
--mensajeEstado varchar(10), 	
--mensajeTexto varchar(1000), 
--archivoId int
--)

go
Alter table mensaje
alter column mensajeId int not Null

go
Alter table mensaje
add Constraint Pk_mensajeId Primary Key (mensajeId)

go
alter table mensaje
Add Constraint fk_chatId_mensaje foreign Key (chatId) references chat(chatId)

go
alter table mensaje
Add Constraint fk_usuarioId_mensaje foreign Key (usuarioId) references usuario(usuarioId)

go
alter table mensaje
Add Constraint fk_archivoId_mensaje foreign Key (archivoId) references archivo(archivoId)

go
alter table mensaje
add constraint ck_mensajeTipo check (mensajeTipo IN ('Texto', 'Audio', 'Video', 'Imagen'))

go
alter table mensaje
add constraint ck_mensajeEstado check (mensajeEstado IN ('Enviado', 'Pendiente'))


--CREATE TABLE llamada(
--llamador int, 
--receptor int, 
--fechaComienzo datetime, 
--fechaFin datetime, 
--duracion int, 
--respondida bit
--)

go
Alter table llamada
alter column llamador int not Null

go
Alter table llamada
alter column receptor int not Null

go
Alter table llamada
alter column fechaComienzo Datetime not Null

go
Alter table llamada
alter column respondida bit not Null

go
Alter table llamada
add Constraint Pk_llamador_receptor_fchaComienzo Primary Key (llamador, receptor, fechaComienzo)

go
alter table llamada
Add Constraint fk_llamador foreign Key (llamador) references usuario(usuarioId)

go
alter table llamada
Add Constraint fk_receptor foreign Key (receptor) references usuario(usuarioId)



--CREATE TABLE contacto(
--usuarioId int, 
--contactoId int
--)

go
Alter table contacto
alter column usuarioId int not Null

go
Alter table contacto
alter column contactoId int not Null

go
Alter table contacto
add Constraint Pk_usuarioId_contactoId Primary Key (usuarioId, contactoId)

go
alter table contacto
Add Constraint fk_usuarioId_contacto foreign Key (usuarioId) references usuario(usuarioId)

go
alter table contacto
Add Constraint fk_contactoId_contacto foreign Key (contactoId) references usuario(usuarioId)


--CREATE TABLE bloqueado(
--usuarioId int, 
--contactoBloqueadoId int, 
--fechaBloqueado datetime
--)

go
Alter table bloqueado
alter column usuarioId int not Null

go
Alter table bloqueado
alter column contactoBloqueadoId int not Null

go
Alter table bloqueado
add Constraint Pk_usuarioId_contactoBloqueadoId Primary Key (usuarioId, contactoBloqueadoId)

go
alter table bloqueado
Add Constraint fk_usuarioId_bloqueado foreign Key (usuarioId) references usuario(usuarioId)

go
alter table bloqueado
Add Constraint fk_contactoBloqueadoId foreign Key (contactoBloqueadoId) references usuario(usuarioId)





