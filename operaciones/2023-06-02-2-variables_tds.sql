set search_path=base;

-- reemplazar adecuadamente owner y, admin segun entorno
set role ut_owner;
--set role  TEST_owner;
--set role CAPA_owner;

--sql2tabla_datos($esquema,$tabla,$operativo)
--   para cargar tabla_datos y variables
select sql2tabla_datos('base', 'tem', 'UT_2023');

select sql2tabla_datos('base', unidad_analisis, operativo)
from unidad_analisis u join parametros p using (operativo)
where unico_registro and u.operativo=p.operativo
order by orden;

-- copiado de /meta_enc/install/complete_variables.sql
--   para  cargar variables_opciones:
insert into variables_opciones (operativo, tabla_datos, variable, opcion, nombre, orden)
select var.operativo, var.tabla_datos, var.variable, o.casillero::integer, string_agg(o.nombre,'/'), min(o.orden)
    from casilleros o join casilleros p on o.operativo=p.operativo and o.padre=(case when p.tipoc='OM' then p.padre||'/'||p.casillero else p.casillero end) and p.var_name is not null and o.tipoc='O'
      join variables var on var.operativo=p.operativo and p.var_name= variable -- tabla_datos ??? es lo que quiero determinar
    group by 1,2,3,4 --descartar opciones duplicadas por disTintos formularios
    order by var.operativo, var.tabla_datos, var.variable;


update variables v
set nombre = c.nombre
from casilleros c
where v.variable=c.var_name and v.clase = 'interna';

