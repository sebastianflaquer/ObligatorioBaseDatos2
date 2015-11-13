
-- a. crear una vista 'pendientesEnviarPorTipoMensaje' que muestre para cada tipo de mensaje, la 
-- cantidad de mensajes pendientes de enviar en el año actual.
create view pendientesEnviarPorTipoMensaje as (
	select m.mensajeTipo, COUNT(m.mensajeTipo) Cantidad
	from mensaje m
	where m.mensajeEstado = 'Pendiente'
	and year(m.fechaMensaje) = YEAR(GETDATE())
	GROUP BY mensajeTipo
)

/* ejecutar la vista */
-- select *
-- from pendientesEnviarPorTipoMensaje