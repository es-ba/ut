--cálculo de pre_sorteo para supervisión aleatoria
--poner el rol que corresponda según el entorno en cual estamos corriendo este script
set role ut2023_owner;
set search_path=base;

select count(*) from tem where dominio=3 and operativo='UT_2023'; --4200
with a as(
select enc,random() vrandom
  from tem
  where dominio=3 and operativo='UT_2023'
order by enc
    )
update tem  t set pre_sorteo=b.pre_sorteo
 from (
  select enc, case when vrandom <=0.1 then 1 else 0 end as pre_sorteo --así quedan aprox el 10% de elegidas (con valor 1)
    from a
    ) b
where t.enc=b.enc and t.operativo='UT_2023';
/* comprobación 
select pre_sorteo,count(*)
  from tem
  where dominio=3
  group by 1
  order by pre_sorteo;
  0    3756
  1     444   -- son las elegidas para supervision aleatoria 
 
*/
-- SUPERVISION_ALEATORIA=1 PRESENCIAL, SUPERVISION_ALEATORIA=2 TELEFONICA
--van a supervisión presencial las seleccionadas aleatorias no_encuestables
--van a supervisión telefónica aquellas seleccionadas aleatorias rea con teléfono (tel1 ó tel2 ó telms) sin teléfono telefónica
--la idea es armar una función trigger para determinar tipo de supervisión aleatoria  (por el momento  comprobación de casos no encuestables)
/*comprobación de casos posibles no encuestables, se podrían setear en la primer tanda de casos */
select t.enc, t.rea, t.norea, pre_sorteo, r.grupo0
    from base.tem t
    left join base.no_rea r  on norea::text=no_rea
     where t.operativo='UT_2023' and t.rea=2  and r.grupo0 in ('no encuestable')  --no_encuestable van a supervision aleatoria presencial
         and t.dominio=3 and t.supervision_aleatoria is null and pre_sorteo=1 
     order by t.enc;