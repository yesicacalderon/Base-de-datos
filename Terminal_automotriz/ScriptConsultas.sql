
-- 1).
SELECT		m.nombre as Nombre, COUNT(a.chasis)"Cantidad Vehículos", month(au.fecha_hora_egreso)"Mes"
FROM		Auto_en_produccion		au
INNER JOIN	Auto					a	on au.cod_chasis=a.chasis 
inner join  Modelo 					m on a.codigo_modelo=m.id_modelo
WHERE		au.cod_estacion=5  		AND		   au.fecha_hora_egreso is not null
GROUP BY	month(fecha_hora_egreso),a.codigo_modelo;

-- //////////////////////////////////////////////////////////////////////////
-- 2) 
SELECT		SUM(de.cantidad)"Total autos pedidos", month(p.fecha_pedido)"Mes de 2019", c.nombre"Concesionaria", m.nombre"Modelo"
FROM		Concesionaria								c
INNER JOIN	Pedido										p	on	c.id_concesionaria=p.cod_concesionaria
INNER JOIN	Detalle_pedido								de	on	p.id_pedido=de.cod_pedido
INNER JOIN	Modelo										m	on	de.cod_modelo=m.id_modelo
GROUP BY	month(p.fecha_pedido), de.cod_modelo;
-- //////////////////////////////////////////////////////////////////////////
-- 3)
SELECT		c.nombre"Concesionaria", If(p.cod_concesionaria>0,"Si","No")"Hizo pedido??"
FROM		Concesionaria			c
LEFT JOIN	Pedido					p 	on	c.id_concesionaria=p.cod_concesionaria;
-- //////////////////////////////////////////////////////////////////////////					
-- 4)
SELECT 	nombre"Modelo de Vehículo"
FROM	Modelo;
-- //////////////////////////////////////////////////////////////////////////
-- 5) 
SELECT		a.chasis"Auto", m.nombre"Modelo", ap.fecha_hora_ingreso"Fecha ingreso a estación", e.nombre"Estacion"
FROM		Auto 				a
LEFT JOIN	Modelo 				m	on a.codigo_modelo=m.id_modelo
LEFT JOIN	Auto_en_produccion 	ap	on a.chasis=ap.cod_chasis
LEFT JOIN	Estacion_trabajo 	e	on ap.cod_estacion=e.id_estacion;
-- //////////////////////////////////////////////////////////////////////////
-- 6) 
SELECT		a.chasis"Auto", if(ap.cod_estacion is null,"A fabricar",if(ap.cod_estacion=5,"Terminado",e.nombre))"Estado", m.nombre"Modelo", ap.fecha_hora_ingreso"Fecha ingreso a estación"
FROM		Auto 					a
LEFT JOIN	Modelo					m				on a.codigo_modelo=m.id_modelo
LEFT JOIN	Auto_en_produccion 		ap				on a.chasis=ap.cod_chasis
LEFT JOIN	Estacion_trabajo		e				on ap.cod_estacion=e.id_estacion
ORDER BY	ap.cod_estacion;
-- //////////////////////////////////////////////////////////////////////////
-- 7) 
SELECT		a.chasis"Auto", if(ap.cod_estacion is null,"A fabricar",if(ap.cod_estacion=5,"Terminado",e.nombre))"Estado", m.nombre"Modelo", ap.fecha_hora_ingreso"Fecha ingreso a estación", a.codigo_pedido"Nº Pedido"
FROM		Auto 					a
LEFT JOIN	Modelo					m				on a.codigo_modelo=m.id_modelo
LEFT JOIN	Auto_en_produccion 		ap				on a.chasis=ap.cod_chasis
LEFT JOIN	Estacion_trabajo		e				on ap.cod_estacion=e.id_estacion
ORDER BY	a.codigo_pedido;
-- //////////////////////////////////////////////////////////////////////////
-- 8) Anda, es aburrido
SELECT		c.nombre"Concesionaria", m.nombre"Modelo Vehículo"
FROM		Modelo m			LEFT JOIN		Detalle_pedido d		on		m.id_modelo=d.cod_modelo
								LEFT JOIN		Pedido		   p		on		d.cod_pedido=p.id_pedido
								LEFT JOIN		Concesionaria  c		on		p.cod_concesionaria=c.id_concesionaria
                                ORDER BY		c.id_concesionaria;
-- //////////////////////////////////////////////////////////////////////////
-- 9) 
select i.* from detalle_insumo d inner join insumo i on i.id_insumo=d.codigo_insumo where d.codigo_estacion in(
select detalle.estacion from (select au.cod_estacion as estacion, au.cod_chasis as chasis
From       Auto    a
inner join  Auto_en_produccion au
On    a.chasis=au.cod_chasis
inner join Estacion_trabajo e on au.cod_estacion=e.id_estacion
where au.fecha_hora_ingreso is null) as detalle);
-- //////////////////////////////////////////////////////////////////////////
-- 10)
select d.cod_pedido as pedido, d.cod_modelo as modelo, d.cantidad from Detalle_pedido d 
inner join Auto a on a.codigo_pedido=d.cod_pedido and a.codigo_modelo=d.cod_modelo
inner join auto_en_produccion au on a.chasis=au.cod_chasis 
where au.fecha_hora_ingreso is null;

