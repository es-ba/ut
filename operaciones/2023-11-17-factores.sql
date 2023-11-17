set search_path= base, comun;
--subir los factores usando txt-to-sql en nuevo esquema operaciones

--revision
select count(*) from tem t join operaciones.ut2023_factores f on t.enc::integer=f.enc;
--1789
select rea,norea,cant_h, bool_and(w_pers_caba is not null),count(*)
from tem t join operaciones.ut2023_factores f on t.enc::integer=f.enc
group by 1,2,3
order by 1,2,3;-- rea 1 y 4
select count(*) from tem where rea=1--1760;
select * from operaciones.ut2023_factores
where hogar>1; --8

select t.rea, h.entrea, p.entreaind, count(*)
from tem t join operaciones.ut2023_factores f on t.enc::integer=f.enc
join hogares h on t.enc=h.vivienda and h.hogar=f.hogar
join personas p on f.enc::text=p.vivienda and p.hogar=f.hogar and p.persona=f.persona
group by 1,2,3;
--4	1	1	21
--1	1	1	1768;

select t.rea, h.entrea, p.entreaind, count(*)
from tem t 
join hogares h on t.enc=h.vivienda 
join personas p using (vivienda,hogar)
where --entrea=1 and 
entreaind=1 --and rea in (1,4)
group by 1,2,3;
--1	1	1	1768
--4	1	1	21

select count(*) from personas
where entreaind=1; --1789

select h.vivienda, h.hogar,rea, h.entrea, count(*) filter (where entreaind=1) cant_i1_resp
from tem t 
join hogares h on t.enc=h.vivienda 
join personas p using (vivienda,hogar)
where  rea in (1,4)
group by 1,2,3,4
having count(*) filter (where entreaind=1)=1;

select entreaind,* from personas
where vivienda='24007' and hogar=2 ;
order by 1,2,3,4,5;

--carga
alter table personas
  add column if not exists w_pers_caba integer,
  add column if not exists w_pers_sd integer,
  add column if not exists w_pers_lv integer;
  
  update personas p
    set w_pers_caba= f.w_pers_caba,
        w_pers_sd= f.w_pers_sd,
        w_pers_lv= f.w_pers_lv
    from operaciones.ut2023_factores f    
    where f.enc::text=p.vivienda and p.hogar=f.hogar and p.persona=f.persona
      and p.entreaind=1; --guarda 

--control suma total
select sum(w_pers_caba) s_pers,sum(w_pers_sd) s_pers_sd,sum(w_pers_lv) s_pers_lv
from personas;
--2522631	2522635	2522648
-- coincide con la planilla

--metadatos variables
--select * from variables where tabla_datos='personas';
insert into variables(operativo, tabla_datos, variable, nombre, tipovar, clase, es_nombre_unico, activa, cerrada, grupo, orden) values
('UT_2023', 'personas', 'w_pers_caba', 'factor persona', 'numero', 'interna', true, true, true, 'factores', 100),
('UT_2023', 'personas', 'w_pers_sd', 'factor persona Sab-Dom', 'numero', 'interna', true, true, true, 'factores', 101),
('UT_2023', 'personas', 'w_pers_lv', 'factor persona Lun-Vie', 'numero', 'interna', true, true, true, 'factores', 102);
