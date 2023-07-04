set search_path=base;

alter table parametros add dias_finc integer not null default 7;
alter table tareas_tem add column ts_entrada timestamp;

insert into tareas (operativo, tarea, nombre) values 
    ('UT_2023','finc', 'fin campo'),
    ('UT_2023','anac', 'análisis de campo'),
    ('UT_2023','proc', 'procesamiento');

insert into tareas_tem (operativo, enc, tarea)
    select ta.operativo, ta.enc, ta.tarea
      from (select ta.*, t.enc,t.area from tareas ta, tem t where ta.operativo=t.operativo and ta.tarea in ('finc','anac','proc')) ta 
      where ta.operativo= (select operativo from parametros where unico_registro) 
          and not (ta.operativo, ta.enc, ta.tarea) in (select operativo, enc, tarea from tareas_tem)
    order by 1,3,2;

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
begin
     select rea, norea, tarea_actual, grupo0, supervision_aleatoria 
        into v_rea, v_norea, v_tarea_actual, v_grupo0, v_supervision_aleatoria 
        from tem t
        left join no_rea nr  on nr.no_rea= norea::text 
        where operativo = new.operativo and enc = new.enc;    
    if new.verificado='1' then
        if v_tarea_actual='encu' then
            case when  v_grupo0 in ('ausentes', 'rechazos') then
                    v_proxtarea='recu';
                 when  v_grupo0 in ('no encuestable') then 
                    v_proxtarea='supe';
                 when  v_rea=1 and (v_supervision_aleatoria is not null or new.supervision_dirigida is not null) then 
                    v_proxtarea='supe';
                 else 
                    v_proxtarea='finc';
            end case;
        elsif v_tarea_actual='recu' then
            case when  v_grupo0 in ('no encuestable') then 
                    v_proxtarea='supe';
                 when  v_rea=1 and (v_supervision_aleatoria is not null or new.supervision_dirigida is not null) then 
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
