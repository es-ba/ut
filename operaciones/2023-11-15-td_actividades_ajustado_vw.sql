set search_path=base;
--definicion de tds, variables y relaciones
--para poder usar la vista actividades_ajustado_vw en el calculo

select sql2tabla_datos('base', 'actividades_ajustado_vw', 'UT_2023');
update tabla_datos 
    set observaciones='vista auxiliar para el calculo de tiempo sin simultaneidad'
    where tabla_datos='actividades_ajustado_vw';

--no se van a mostrar todas las columnas
delete from variables 
    where tabla_datos~'actividades_ajustado'
        and variable ~'^(ajustado|ajustado_min|desde|detalle|hasta|simultaneidad_maxima|t_con_simu_hm|t_con_simu_min)$';

--relaciones 
--select * from relaciones where tabla_datos~'acti'
insert into relaciones(operativo,tabla_datos,tiene, misma_pk,tabla_relacionada, aridad)
  select operativo, tabla_datos, 'actividades_ajustado_vw', misma_pk, 'actividades_ajustado_vw',aridad
    from relaciones 
    where tabla_datos='actividades' and tiene='actividades_calculada';
insert into rel_vars(operativo, tabla_datos, tiene, orden, tabla_relacionada, campo_datos, campo_tiene)
  select operativo, tabla_datos,'actividades_ajustado_vw' , orden, 'actividades_ajustado_vw', campo_datos, campo_tiene
    from rel_vars
    where tabla_datos='actividades' and tiene='actividades_calculada'
    order by orden;
