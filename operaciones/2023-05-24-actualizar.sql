--set role dmencu_owner;
set search_path=base;

--DROP FUNCTION if exists asignar_desasignar_tareas_tem_trg();
CREATE OR REPLACE FUNCTION asignar_desasignar_tareas_tem_trg()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
    declare 
        v_estado_al_asignar text;
        v_tarea_actual  text;
        v_tarea_proxima text;
begin
    select tarea_actual, habilitada, tarea_proxima into v_tarea_actual, v_tarea_proxima
        from tem 
        where operativo = new.operativo and enc = new.enc;
    select estado_al_asignar into v_estado_al_asignar from estados where operativo = new.operativo and estado = new.estado;
    if new.asignado is null then
        if coalesce(v_tarea_actual,'nulo') = new.tarea then    
            update tem 
                set tarea_proxima = new.tarea, tarea_actual = new.tarea_anterior, estado_actual = new.estado
                where operativo = new.operativo and enc = new.enc;
        end if;
    else
        if v_tarea_actual is distinct from new.tarea then    
            update tem 
                set tarea_actual = tarea_proxima, tarea_proxima = null , estado_actual = new.estado
                where operativo = new.operativo and enc = new.enc;
        end if;
    end if;
    return new;
end;
$BODY$;

DROP TRIGGER IF EXISTS asignar_desasignar_tareas_tem_trg ON tareas_tem;
CREATE TRIGGER asignar_desasignar_tareas_tem_trg
   AFTER UPDATE OF asignado
   ON tareas_tem
   FOR EACH ROW
   EXECUTE PROCEDURE asignar_desasignar_tareas_tem_trg();   

--set role dmencu_owner;
--set search_path=base;

CREATE OR REPLACE FUNCTION validar_tareas_tem_trg()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $BODY$
declare 
    v_habilitada    boolean;
    v_tarea_actual  text;
    v_tarea_proxima text;
    v_permite_asignar boolean;
    v_estado_al_asignar text;
begin
    select tarea_actual, habilitada, tarea_proxima into v_tarea_actual, v_habilitada, v_tarea_proxima
        from tem 
        where operativo = new.operativo and enc = new.enc;
    select permite_asignar, estado_al_asignar into v_permite_asignar, v_estado_al_asignar
        from estados
        where operativo = new.operativo and estado =  new.estado;
    if v_habilitada then
        if old.asignado is distinct from new.asignado then 
            if not v_permite_asignar then
                raise exception 'Error: no es posible asignar en la encuesta % del operativo % ya que su estado no lo permite', new.enc, new.operativo;
            end if;
            if new.recepcionista is null then 
                raise exception 'Error: no es posible asignar en la encuesta % del operativo % ya que no se indicó un/a recepcionista', new.enc, new.operativo;
            end if;
            if not (new.tarea = coalesce(v_tarea_actual,'nulo') or new.tarea = coalesce(v_tarea_proxima,'nulo')) then
                raise exception 'Error: no es posible modificar la encuesta % del operativo % ya que la tarea actual definida en TEM no coincide con la tarea %', new.enc, new.operativo, new.tarea;
            end if;
        end if;
        if old.recepcionista is distinct from new.recepcionista then
            if new.recepcionista is null and new.asignado is not null then 
                raise exception 'Error: no es posible quitar el recepcionista de la encuesta % del operativo % ya que se la misma se encuentra asignada', new.enc, new.operativo;
            end if;
        end if;
        if old.asignado is distinct from new.asignado then
            if new.asignado is null then
                new.estado = '0D';
            else
                if v_tarea_actual is distinct from new.tarea then    
                    if v_estado_al_asignar is not null then
                        new.estado = v_estado_al_asignar;
                        new.tarea_anterior = v_tarea_actual;
                    end if;
                end if;
            end if;
        end if;
    else 
        raise exception 'Error: la encuesta % del operativo % se encuentra deshabilitada', new.enc, new.operativo;
    end if;
    return new;
end;
$BODY$;

DROP TRIGGER IF EXISTS validar_tareas_tem_trg ON tareas_tem;
CREATE TRIGGER validar_tareas_tem_trg
   BEFORE UPDATE
   ON tareas_tem
   FOR EACH ROW
   EXECUTE PROCEDURE validar_tareas_tem_trg();   
