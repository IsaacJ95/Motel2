--Trigger que actualice comisiones. Cuando un taxista pase de 3 clientes al año,
--suba la comisión en un 50%
create or replace function comision() returns trigger
as 
$comision$
declare
	no_clientes int;
begin
	select count(estandia.codigo_cliente) into no_clientes
	from estandia
	inner join habitacion on habitacion.numero_habitacion = estandia.numero_habitacion
	where estandia.numero_habitacion = new.numero_habitacion 
	and extract(year from estandia.fecha_estadia) = extract(year from new.fecha_estadia);
	if(no_clientes > 3) then
		raise notice 'comision aumentada';
		update pago set recargo_taxi = recargo_taxi + (recargo_taxi * 0.5) where cod_pago = new.cod_pago;
		
	end if;
	return new;
end;
$comision$
language plpgsql;

create trigger comision after
insert on estandia for each row
execute procedure comision();

--Insert
INSERT INTO ESTANDIA VALUES( 9022, 1, 102, 1007, 204, 'Buen estado', '28/05/2019', '10:00:00', '18:00:00');




