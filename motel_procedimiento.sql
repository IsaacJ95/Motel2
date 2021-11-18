-- Un procedimiento en el que ingrese el número de habitación y salga por año cuanto se generó de plata.
create or replace function generar_pago_habitacion(int4)returns setof "record"
as
$body$
select extract(year from estandia.fecha_estadia), sum(pago.valor_pago)
from estandia
inner join pago on pago.cod_pago = estandia.cod_pago
inner join habitacion on habitacion.numero_habitacion = estandia.numero_habitacion
where habitacion.numero_habitacion = $1
group by extract(year from estandia.fecha_estadia), habitacion.numero_habitacion
$body$
language sql;
select * from generar_pago_habitacion(205)
as ("año" double precision, "total_pago" real)
