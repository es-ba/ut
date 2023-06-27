--cálculo de pre_sorteo para supervisión aleatoria
--poner el rol que corresponda según el entorno en cual estamos corriendo este script
set role ut2023_owner;
set search_path=base;

select count(*) from tem where dominio=3 and operativo='UT_2023'; --4200
--pre-sorteo presenciales
with a as(
select enc,random() vrandom
  from tem
  where dominio=3 and operativo='UT_2023'
order by enc
    )
update tem  t set pre_sorteo=b.pre_sorteo
 from (
  select enc, case when vrandom <=0.1 then 1 else 0 end as pre_sorteo --asi quedan aprox el 10% de elegidas (con valor 1 para candidatas a presenciales)
    from a
    ) b
where t.enc=b.enc and t.operativo='UT_2023';
/* comprobación 
select pre_sorteo,count(*)
  from tem
  where dominio=3
  group by 1
  order by pre_sorteo;
    -- son las elegidas para supervision aleatoria  presencial
 
*/
--pre-sorteo telefónicas
with a as(
select enc,random() vrandom
  from tem
  where dominio=3 and operativo='UT_2023' and pre_sorteo=0
order by enc
    )
update tem  t set pre_sorteo=b.pre_sorteo
 from (
  select enc, case when vrandom <=0.1 then 2 else 0 end as pre_sorteo --asi quedan aprox el 10% de elegidas (con valor 2 para candidatas a telefónicas)
    from a
    ) b
where t.enc=b.enc and t.operativo='UT_2023';

/* comprobación 
select pre_sorteo,count(*)
  from tem
  where dominio=3
  group by 1
  order by pre_sorteo;
  -- son las elegidas para supervision aleatoria  telefónica
 
*/

-- SUPERVISION_ALEATORIA=1 PRESENCIAL, SUPERVISION_ALEATORIA=2 TELEFONICA
--van a supervisión aleatoria presencial  aquellas seleccionadas con pre_sorteo=1 que tengan rea=1 o que tengan una norea=no_encuestable
--van a supervisión aleatoria telefónica  aquellas seleccionadas con pre_sorteo=2 que tengan rea=1 y  con  alguna información en los campos teléfono (tel1 ó tel2 ó telms) 
--la idea es armar una función trigger para setear la supervisión aleatoria 
/*comprobación de casos posibles */
/* se puede correr antes de poner en la base el script de csetear_sup_aleat_tareas_tem_trg();
with z as
(
select t.enc, pre_sorteo, supervision_aleatoria, t.rea, t.norea, grupo0,estado,dominio
 
    from base.tem t
      left join base.tareas_tem tt on t.enc=tt.enc and t.tarea_actual=tt.tarea
      left join base.no_rea on t.norea::text=no_rea
      where t.operativo='UT_2023'  and pre_sorteo  in (1,2) and supervision_aleatoria is null and dominio=3 and estado='V'
      order by enc
),
y as
(
select z.enc,pre_sorteo, rea, grupo0, 
    case when concat_ws(coalesce(tel1,''),coalesce(tel2,''),coalesce(tel_ms,''))=''  then 'sin_tel'  else 'tiene' end con_telefono 
 from z
   left join hogares h on z.enc=h.vivienda
   left join personas p on h.vivienda=p.vivienda and h.hogar=p.hogar and h.cr_num_miembro=p.persona 
 )
select enc,rea, pre_sorteo,grupo0, con_telefono,
            case when pre_sorteo=1 and rea=1 then 1 when pre_sorteo=1 and grupo0='no encuestable' then 1 
            when pre_sorteo=2 and con_telefono='tiene' then 2 else null end sup_aleat
from y
order by enc;

*/