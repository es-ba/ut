set search_path=base;

alter table parametros add dias_finc integer not null default 5;
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

alter table tem add column supervision_dirigida integer;

update tem t 
  set supervision_dirigida = aux.supervision_dirigida
  from (select * from tareas_tem where operativo = 'UT_2023' and tarea = 'supe' and supervision_dirigida is not null) aux
  where t.operativo = aux.operativo and t.enc = aux.enc;

alter table tareas_tem drop column supervision_dirigida;


alter table estados add column visible_en_fin_campo boolean not null default false;
alter table estados add column visible_en_analisis_campo boolean not null default false;
alter table estados add column visible_en_procesamiento boolean not null default false;

alter table acciones add column fin_campo boolean not null default false;
alter table acciones add column analisis_campo boolean not null default false;
alter table acciones add column procesa boolean not null default false;

insert into "estados" 
    ("operativo", "estado", "desc_estado", "orden_estado", "permite_asignar", "permite_editar_encuesta", "estado_al_asignar", "visible_en_recepcion", "visible_en_ingreso", "visible_en_fin_campo","visible_en_analisis_campo","visible_en_procesamiento") 
    values ('UT_2023', 'CC', 'Consulta a campo', '90', 'false', 'true', null, 'false', 'false','false','true','true');

update estados set visible_en_fin_campo = true where operativo = 'UT_2023' and estado in ('0D','A');
update estados set visible_en_procesamiento = true where operativo = 'UT_2023' and estado in ('0D','A','CC');

alter table tareas_tem add column adelantar boolean;

insert into "acciones" ("operativo", "eaccion", "abr_eaccion", "desactiva_boton", "path_icono_svg", "desc_eaccion", "confirma", "recepciona", "ingresa","fin_campo", "analisis_campo", "procesa") values
('UT_2023', 'sup_presencial', 'sup_dir', 'false', null, 'pasa la encuesta a supervision dirigida presencial', 'false', 'false','false','true','false','false'),
('UT_2023', 'sup_telef', 'sup_tel', 'false', null, 'pasa la encuesta a supervision dirigida telefonica', 'false', 'false','false','true','false','false'),
('UT_2023', 'no_sup_presencial', 'no_sup_dir', 'false', null, 'revierte preparación de supervision dirigida presencial', 'false', 'false','false','true','false','false'),
('UT_2023', 'no_sup_telef', 'no_sup_tel', 'false', null, 'revierte preparación de supervision dirigida telefonica', 'false', 'false','false','true','false','false');

insert into "estados_acciones" ("operativo", "estado", "eaccion", "condicion", "estado_destino", "eaccion_direccion", "nombre_procedure", "nombre_wscreen") values
('UT_2023', '0D', 'sup_presencial', 'habilitada and estado = ''0D'' and coalesce(te.supervision_dirigida,-10) <> 1 and te.dominio <> 5', '0D', 'avance', 'encuesta_supervisar_presencial', null),
('UT_2023', '0D', 'sup_telef', 'habilitada and estado = ''0D'' and coalesce(te.supervision_dirigida,-10) <> 2 and te.dominio <> 5', '0D', 'avance', 'encuesta_supervisar_telefonica', null),
('UT_2023', '0D', 'no_sup_presencial', 'habilitada and estado = ''0D'' and te.supervision_dirigida = 1', '0D', 'retroceso', 'encuesta_no_supervisar', null),
('UT_2023', '0D', 'no_sup_telef', 'habilitada and estado = ''0D'' and te.supervision_dirigida = 2', '0D', 'retroceso', 'encuesta_no_supervisar', null);
