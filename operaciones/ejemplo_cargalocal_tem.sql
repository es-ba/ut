--EJEMPLO LOCAL PARA CARGA INICIAL DE REGISTROS EN TEM, TAREAS_AREAS Y TAREAS_TEM
set search_path=base;
--set role ut_owner;
/* EN DISCON 
INSERT INTO BASE.areas (operativo, area)
  select 'UT_2023', area
    from BASE.areas
    where operativo='UT_2023';
insert into base.tem (operativo, area,enc)
  select 'UT_2023', area,enc
    from BASE.tem
    where operativo='PREJU_2022'
    order by area,enc; 
insert into tareas (tarea, nombre, rol_asignante, main_form, registra_estado_en_tem, operativo)
  select tarea, nombre, rol_asignante, main_form,registra_estado_en_tem, 'UT_2023'
    from base.tareas
    where operativo='PREJU_2022';
insert into tareas_areas
  select 'UT_2023', tarea, area
    from tareas_areas
    where operativo='PREJU_2022';
insert into tareas_tem(tarea, operativo,enc)
    select tarea, 'UT_2023',enc
    from tareas_tem
    where operativo='PREJU_2022';
    
    
*/



--CONSULTA YA GENERADA POR RAQUEL DESDE SCRIPT en carpeta Operaciones de DMENCU
set search_path=base;
set role ut_owner;

-- Primer seteo con data de asignacion desde areas
-- TODO reveer si agregamos campos asociados a las tareas supe y recu a areas

--delete from tareas_areas;
insert into tareas_areas(operativo, tarea, area, asignado, asignante, obs_asignante)
    select * 
        from (
          select a.operativo, t.tarea, area, case when tarea='encu' then encuestador else null end asignado, recepcionista, obs_recepcionista
            from areas a ,(select t.operativo, t.tarea 
                from tareas t join parametros p on unico_registro and t.operativo=p.operativo
            )t
            where a.operativo= t.operativo and a.operativo='UT_2023'
        ) n
        --where not exists (select 1 from tareas_areas t where t.operativo= n.operativo and t.tarea=n.tarea and t.area=n.area)
        order by 1,2,3;

--delete from tareas_tem;
insert into tareas_tem (operativo, enc, tarea, habilitada, operacion, fecha_asignacion,asignado)
    select ta.operativo, ta.enc, ta.tarea, case when ta.tarea='encu' then true else false end , operacion, fecha_asignacion,asignado
      from (select ta.*, t.enc,t.area from tareas ta, tem t where ta.operativo=t.operativo) ta 
        left join tareas_areas x on x.operativo=ta.operativo and x.tarea=ta.tarea and x.area=ta.area
      where x.operativo= (select operativo from parametros where unico_registro) 
          and not (ta.operativo, ta.enc, ta.tarea) in (select operativo, enc, tarea from tareas_tem)
          and ta.main_form is not null
    order by 1,3,2;

