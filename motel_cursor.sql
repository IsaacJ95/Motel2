--Cursor donde la habitación especificada, numero de veces de visita, numero de plata 
--que genero y plata que se pago al taxista.
do $$
declare
	contador int;
	datos record;
	sum1 real = 0;
	sum2 real = 0;
	cont1 int = 0;
	cur1 cursor is select * from estandia
	inner join pago on pago.cod_pago = estandia.cod_pago
	inner join habitacion on habitacion.numero_habitacion = estandia.numero_habitacion
	where habitacion.numero_habitacion = 201;
begin
	for contador in cur1 loop
		sum1 = sum1 + sum(contador.valor_pago);
	end loop;
	for contador in cur1 loop
		sum2 = sum2 + sum(contador.recargo_taxi);
	end loop;
	for contador in cur1 loop
		cont1 = cont1 + count(contador.codigo_cliente);
	end loop;
open cur1;
fetch cur1 into datos;
raise notice 'No habitacion: %, Numero visitas: %, Total pago: %, Total pago taxista: %',
datos.numero_habitacion, cont1, sum1, sum2;
end $$
language 'plpgsql'