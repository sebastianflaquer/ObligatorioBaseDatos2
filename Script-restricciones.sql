
--CREATE TABLE pais(
--paisId char(3), 
--paisNombre varchar(50)
--)

Alter table pais
alter column paisId char(3) not Null

Alter table pais
add Constraint Pk_paisId Primary Key (paisId)

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


Alter table chat
alter column chatId int not Null

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


Alter table chatParticipante
alter column chatId int not Null

alter table chatParticipante 
alter column usuarioParticipante int not Null

alter table chat 
add chatId int primary key



-Las 2 son foreignkey
-Las 2 son PrimaryKey

--CREATE TABLE grupoAdmin(
--chatId int, 
--usuarioId int
--)

-Las 2 son foreignkey
-Las 2 son PrimaryKey

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

mensajeId - Primary
chatId - foreign de chat participante.
usuarioId - foreign
mensajeTipo - Chek - Texto, Audio, Video, Imagen
mensajeEstado - Chek - Enviado, Pendiente
archivoId - Foreign de Archivo

--CREATE TABLE archivo(
--archivoId int, 
--archivoContenido VARBINARY(MAX)
--)

archivoId - Primary Identity
Todos requeridos

--CREATE TABLE llamada(
--llamador int, 
--receptor int, 
--fechaComienzo datetime, 
--fechaFin datetime, 
--duracion int, 
--respondida bit
--)

llamador y receptor - Foreign de usuario
respondida Not Null


--CREATE TABLE contacto(
--usuarioId int, 
--contactoId int
--)

usuarioId y contactoId son foreingkey y primary

--CREATE TABLE bloqueado(
--usuarioId int, 
--contactoBloqueadoId int, 
--fechaBloqueado datetime
--)

usuarioId y contactoBloqueadoId primary
usuarioId y contactoBloqueadoId son foreign



