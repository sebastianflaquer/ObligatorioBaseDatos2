create database ObligatorioBD2

use ObligatorioBD2;

CREATE TABLE [dbo].[pais](
	[paisId] [char](3) NOT NULL,
	[paisNombre] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_paisId] PRIMARY KEY CLUSTERED 
(
	[paisId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[archivo]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[archivo](
	[archivoContenido] [int] NOT NULL,
	[archivoId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[archivoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[usuarioTelefono] [varchar](20) NOT NULL,
	[usuarioNombre] [varchar](40) NULL,
	[usuarioUltimaActividad] [varchar](20) NOT NULL,
	[usuarioEstado] [varchar](30) NULL,
	[paisId] [char](3) NOT NULL,
	[usuarioId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Un_usuarioTelefono] UNIQUE NONCLUSTERED 
(
	[usuarioTelefono] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [i1] ON [dbo].[usuario] 
(
	[paisId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chat]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chat](
	[usuarioCreador] [int] NOT NULL,
	[chatFechaCreacion] [datetime] NOT NULL,
	[esGrupo] [bit] NOT NULL,
	[chatId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[chatId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [i2] ON [dbo].[chat] 
(
	[usuarioCreador] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bloqueado]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bloqueado](
	[usuarioId] [int] NOT NULL,
	[contactoBloqueadoId] [int] NOT NULL,
	[fechaBloqueado] [datetime] NULL,
 CONSTRAINT [Pk_usuarioId_contactoBloqueadoId] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC,
	[contactoBloqueadoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contacto]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contacto](
	[usuarioId] [int] NOT NULL,
	[contactoId] [int] NOT NULL,
 CONSTRAINT [Pk_usuarioId_contactoId] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC,
	[contactoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[llamada]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[llamada](
	[llamador] [int] NOT NULL,
	[receptor] [int] NOT NULL,
	[fechaComienzo] [datetime] NOT NULL,
	[fechaFin] [datetime] NULL,
	[duracion] [int] NULL,
	[respondida] [bit] NOT NULL,
 CONSTRAINT [Pk_llamador_receptor_fchaComienzo] PRIMARY KEY CLUSTERED 
(
	[llamador] ASC,
	[receptor] ASC,
	[fechaComienzo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mensaje]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mensaje](
	[mensajeId] [int] NOT NULL,
	[chatId] [int] NULL,
	[usuarioId] [int] NULL,
	[fechaMensaje] [datetime] NULL,
	[mensajeTipo] [varchar](6) NULL,
	[mensajeEstado] [varchar](10) NULL,
	[mensajeTexto] [varchar](1000) NULL,
	[archivoId] [int] NULL,
 CONSTRAINT [Pk_mensajeId] PRIMARY KEY CLUSTERED 
(
	[mensajeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [i5] ON [dbo].[mensaje] 
(
	[chatId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [i6] ON [dbo].[mensaje] 
(
	[usuarioId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [i7] ON [dbo].[mensaje] 
(
	[archivoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grupoAdmin]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grupoAdmin](
	[chatId] [int] NOT NULL,
	[usuarioId] [int] NOT NULL,
 CONSTRAINT [Pk_chatId_usuarioId] PRIMARY KEY CLUSTERED 
(
	[chatId] ASC,
	[usuarioId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [i4] ON [dbo].[grupoAdmin] 
(
	[usuarioId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chatParticipante]    Script Date: 11/13/2015 13:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chatParticipante](
	[chatId] [int] NOT NULL,
	[usuarioParticipante] [int] NOT NULL,
 CONSTRAINT [Pk_chatId_usuarioParticipante] PRIMARY KEY CLUSTERED 
(
	[chatId] ASC,
	[usuarioParticipante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [i3] ON [dbo].[chatParticipante] 
(
	[usuarioParticipante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Check [ck_mensajeEstado]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[mensaje]  WITH CHECK ADD  CONSTRAINT [ck_mensajeEstado] CHECK  (([mensajeEstado]='Pendiente' OR [mensajeEstado]='Enviado'))
GO
ALTER TABLE [dbo].[mensaje] CHECK CONSTRAINT [ck_mensajeEstado]
GO
/****** Object:  Check [ck_mensajeTipo]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[mensaje]  WITH CHECK ADD  CONSTRAINT [ck_mensajeTipo] CHECK  (([mensajeTipo]='Imagen' OR [mensajeTipo]='Video' OR [mensajeTipo]='Audio' OR [mensajeTipo]='Texto'))
GO
ALTER TABLE [dbo].[mensaje] CHECK CONSTRAINT [ck_mensajeTipo]
GO
/****** Object:  ForeignKey [fk_contactoBloqueadoId]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[bloqueado]  WITH CHECK ADD  CONSTRAINT [fk_contactoBloqueadoId] FOREIGN KEY([contactoBloqueadoId])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[bloqueado] CHECK CONSTRAINT [fk_contactoBloqueadoId]
GO
/****** Object:  ForeignKey [fk_usuarioId_bloqueado]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[bloqueado]  WITH CHECK ADD  CONSTRAINT [fk_usuarioId_bloqueado] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[bloqueado] CHECK CONSTRAINT [fk_usuarioId_bloqueado]
GO
/****** Object:  ForeignKey [fk_usuarioCreador]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[chat]  WITH CHECK ADD  CONSTRAINT [fk_usuarioCreador] FOREIGN KEY([usuarioCreador])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[chat] CHECK CONSTRAINT [fk_usuarioCreador]
GO
/****** Object:  ForeignKey [fk_chatId]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[chatParticipante]  WITH CHECK ADD  CONSTRAINT [fk_chatId] FOREIGN KEY([chatId])
REFERENCES [dbo].[chat] ([chatId])
GO
ALTER TABLE [dbo].[chatParticipante] CHECK CONSTRAINT [fk_chatId]
GO
/****** Object:  ForeignKey [fk_usuarioParticipante]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[chatParticipante]  WITH CHECK ADD  CONSTRAINT [fk_usuarioParticipante] FOREIGN KEY([usuarioParticipante])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[chatParticipante] CHECK CONSTRAINT [fk_usuarioParticipante]
GO
/****** Object:  ForeignKey [fk_contactoId_contacto]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[contacto]  WITH CHECK ADD  CONSTRAINT [fk_contactoId_contacto] FOREIGN KEY([contactoId])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[contacto] CHECK CONSTRAINT [fk_contactoId_contacto]
GO
/****** Object:  ForeignKey [fk_usuarioId_contacto]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[contacto]  WITH CHECK ADD  CONSTRAINT [fk_usuarioId_contacto] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[contacto] CHECK CONSTRAINT [fk_usuarioId_contacto]
GO
/****** Object:  ForeignKey [fk_chatId_grupoAdmin]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[grupoAdmin]  WITH CHECK ADD  CONSTRAINT [fk_chatId_grupoAdmin] FOREIGN KEY([chatId])
REFERENCES [dbo].[chat] ([chatId])
GO
ALTER TABLE [dbo].[grupoAdmin] CHECK CONSTRAINT [fk_chatId_grupoAdmin]
GO
/****** Object:  ForeignKey [fk_usuarioId_grupoAdmin]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[grupoAdmin]  WITH CHECK ADD  CONSTRAINT [fk_usuarioId_grupoAdmin] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[grupoAdmin] CHECK CONSTRAINT [fk_usuarioId_grupoAdmin]
GO
/****** Object:  ForeignKey [fk_llamador]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[llamada]  WITH CHECK ADD  CONSTRAINT [fk_llamador] FOREIGN KEY([llamador])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[llamada] CHECK CONSTRAINT [fk_llamador]
GO
/****** Object:  ForeignKey [fk_receptor]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[llamada]  WITH CHECK ADD  CONSTRAINT [fk_receptor] FOREIGN KEY([receptor])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[llamada] CHECK CONSTRAINT [fk_receptor]
GO
/****** Object:  ForeignKey [fk_archivoId_mensaje]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[mensaje]  WITH CHECK ADD  CONSTRAINT [fk_archivoId_mensaje] FOREIGN KEY([archivoId])
REFERENCES [dbo].[archivo] ([archivoId])
GO
ALTER TABLE [dbo].[mensaje] CHECK CONSTRAINT [fk_archivoId_mensaje]
GO
/****** Object:  ForeignKey [fk_chatId_mensaje]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[mensaje]  WITH CHECK ADD  CONSTRAINT [fk_chatId_mensaje] FOREIGN KEY([chatId])
REFERENCES [dbo].[chat] ([chatId])
GO
ALTER TABLE [dbo].[mensaje] CHECK CONSTRAINT [fk_chatId_mensaje]
GO
/****** Object:  ForeignKey [fk_usuarioId_mensaje]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[mensaje]  WITH CHECK ADD  CONSTRAINT [fk_usuarioId_mensaje] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[mensaje] CHECK CONSTRAINT [fk_usuarioId_mensaje]
GO
/****** Object:  ForeignKey [fk_paisId]    Script Date: 11/13/2015 13:13:42 ******/
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [fk_paisId] FOREIGN KEY([paisId])
REFERENCES [dbo].[pais] ([paisId])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [fk_paisId]
GO
