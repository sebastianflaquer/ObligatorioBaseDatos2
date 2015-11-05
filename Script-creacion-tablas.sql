Create database ObligatorioBD2;

use ObligatorioBD2;

CREATE TABLE pais(
paisId char(3), 
paisNombre varchar(50)
)

CREATE TABLE usuario(
usuarioId int, 
usuarioTelefono varchar(20), 
usuarioNombre varchar(40), 
usuarioUltimaActividad datetime,
usuarioEstado varchar(30), 
paisId char(3)
)

CREATE TABLE chat(
chatId int, 
usuarioCreador int, 
chatFechaCreacion datetime, 
esGrupo bit
)

CREATE TABLE chatParticipante(
chatId int, 
usuarioParticipante int
)

CREATE TABLE grupoAdmin(
chatId int, 
usuarioId int
)

CREATE TABLE mensaje(
mensajeId int, 
chatId int, 
usuarioId int, 
fechaMensaje datetime, 
mensajeTipo varchar(6),
mensajeEstado varchar(10), 	
mensajeTexto varchar(1000), 
archivoId int
)

CREATE TABLE archivo(
archivoId int, 
archivoContenido VARBINARY(MAX)
)

CREATE TABLE llamada(
llamador int, 
receptor int, 
fechaComienzo datetime, 
fechaFin datetime, 
duracion int, 
respondida bit
)

CREATE TABLE contacto(
usuarioId int, 
contactoId int
)

CREATE TABLE bloqueado(
usuarioId int, 
contactoBloqueadoId int, 
fechaBloqueado datetime
)
