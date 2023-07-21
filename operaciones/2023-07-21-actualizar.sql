set role ut2023_owner;
set search_path=base;

CREATE OR REPLACE FUNCTION determinar_tarea_proxima_trg()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
    declare
        v_tarea_actual  text;
        v_rea integer;
        v_norea integer;
        v_grupo0 text;
        v_proxtarea text;
        v_supervision_aleatoria integer;
        v_supervision_dirigida integer;
begin
     select rea, norea, tarea_actual, grupo0, supervision_aleatoria, supervision_dirigida
        into v_rea, v_norea, v_tarea_actual, v_grupo0, v_supervision_aleatoria, v_supervision_dirigida 
        from tem t
        left join no_rea nr  on nr.no_rea= norea::text 
        where operativo = new.operativo and enc = new.enc;    
    if new.verificado='1' then
        if v_tarea_actual='encu' then
            case when  v_grupo0 in ('ausentes', 'rechazos') or v_rea in (3,4) then
                    v_proxtarea='recu';
                 when  v_grupo0 in ('no encuestable') then 
                    v_proxtarea='supe';
                 when  v_rea=1 and (v_supervision_aleatoria is not null or v_supervision_dirigida is not null) then 
                    v_proxtarea='supe';
                 else 
                    v_proxtarea='finc';
            end case;
        elsif v_tarea_actual='recu' then
            case when  v_grupo0 in ('no encuestable') then 
                    v_proxtarea='supe';
                 when  v_rea=1 and (v_supervision_aleatoria is not null or v_supervision_dirigida is not null) then 
                    v_proxtarea='supe';
                 else 
                    v_proxtarea='finc';
            end case;
        elsif v_tarea_actual='supe' then
            v_proxtarea='finc';
        end if;
        update tem 
          set tarea_proxima = v_proxtarea
          where operativo = new.operativo and enc = new.enc;
        update tareas_tem
          set ts_entrada = current_timestamp
          where operativo = new.operativo and enc = new.enc and tarea = v_proxtarea;
    elsif new.verificado is null then   --podria llegar a haber otros valores de verificado 
        update tem 
            set tarea_proxima = null 
            where operativo = new.operativo and enc = new.enc;
    else 
        raise exception 'Falta considerar en la encuesta % un caso más de verificado para próxima tarea % ', new.enc, new.verificado;    
    end if;
    return new;
end;
$BODY$;

 ----scripts auxiliares para identificar casos
 --con tarea encu, descargadas con rea 3 ó 4  candidatas a para pasar a  recu (despues que las verifiquen )
 select t.enc, t.rea,tarea_actual, tarea, tarea_proxima,tt.verificado,tt.asignado,tt.operacion,tt.cargado
   from base.tem t
   inner join base.tareas_tem tt on t.operativo=tt.operativo and t.enc=tt.enc and t.tarea_actual=tt.tarea
   where tarea_actual='encu' and  t.rea in (3,4) 
   and tt.operacion='descargar'  and verificado is null and cargado is false;
   
 ----estas están ya en estado proc  --¿deberían volver a recuperación?
   select t.enc, t.rea,tarea_actual, tarea, tarea_proxima,tt.verificado,tt.asignado,tt.operacion,tt.cargado
      from base.tem t
      inner join base.tareas_tem tt on t.operativo=tt.operativo and t.enc=tt.enc and t.tarea_actual=tt.tarea
      where tarea_actual='proc' and  t.rea in (3,4) and estado='A'
      and cargado is false;