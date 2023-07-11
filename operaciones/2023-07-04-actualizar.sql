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
('UT_2023', 'sup_presencial', 'sup_dir', 'false', 'M38.9 23.78l0 -17.02 -7.5 0c-0.01,0.75 -0.63,1.36 -1.39,1.36l-10.02 0c-0.76,0 -1.38,-0.61 -1.39,-1.36l-7.5 0 0 38.02 7.26 0c-0.04,-0.21 -0.06,-0.42 -0.06,-0.64l3.59 -0.08 19.54 0 0 -12.68 -9.74 -9.74 -9.8 9.81 0 12.61 -3.59 0.08 0 -9.11 -0.33 0.33c-1.67,1.67 -4.21,-0.86 -2.54,-2.53 5,-5 10,-10 15,-15 0.7,-0.7 1.83,-0.7 2.53,0l15 15c1.66,1.67 -0.87,4.2 -2.54,2.53l-0.4 -0.4 0 9.18c0,1.92 -1.59,3.51 -3.51,3.51l-19.7 0c-0.48,0 -0.93,-0.1 -1.34,-0.27l-9.56 0c-1.33,0 -2.41,-1.08 -2.41,-2.41l0 -38.4c0,-1.33 1.08,-2.41 2.41,-2.41l7.69 0 0 -0.15c0,-0.76 0.62,-1.39 1.39,-1.39l10.02 0c0.77,0 1.39,0.63 1.39,1.39l0 0.15 7.69 0c1.32,0 2.41,1.09 2.41,2.41l0 19.78 -2.6 -2.57z', 'pasa la encuesta a supervision dirigida presencial', 'false', 'false','false','true','false','false'),
('UT_2023', 'sup_telef', 'sup_tel', 'false', 'M41.5 6.76l0 -0.19c0,-0.66 -0.28,-1.26 -0.71,-1.7 -0.44,-0.44 -1.05,-0.71 -1.7,-0.71l-7.69 0 0 -0.15c0,-0.76 -0.62,-1.39 -1.39,-1.39l-10.02 0c-0.77,0 -1.39,0.63 -1.39,1.39l0 0.15 -7.69 0c-0.66,0 -1.26,0.27 -1.7,0.71 -0.44,0.44 -0.71,1.04 -0.71,1.7l0 38.4c0,0.66 0.27,1.26 0.71,1.7 0.44,0.44 1.04,0.71 1.7,0.71l22.65 0c0.77,0.24 1.6,0.39 2.49,0.43 1.22,0.06 1.82,-0.13 2.9,-0.35 0.96,-0.2 2.11,-0.27 2.64,-1.24 0.37,-0.7 0.22,-1.86 -0.09,-2.99l0 -36.47 -2.6 0 0 31.43c-0.06,-0.05 -0.13,-0.1 -0.2,-0.14 -1.09,-0.64 -2.22,-0.32 -3.02,-0.13l-1.37 0.33c-2.88,0.79 -4.02,-3.6 -4.36,-5.22 -0.44,-2.03 -1.64,-7.34 0.65,-8.63 0.5,-0.29 0.86,-0.29 1.4,-0.35 0.53,-0.06 0.93,-0.16 1.44,-0.24 2.6,-0.41 3.11,-2.19 3.03,-4.68 -0.05,-1.44 0.08,-4.9 -1.71,-5.45 -0.95,-0.29 -1.85,0.1 -2.91,0.24 -3.03,0.39 -5.89,2.69 -7.24,5.88 -1.74,4.12 -1.28,8.63 -0.72,12.08 0.67,4.15 2.23,9.57 5.51,12.9l-18.3 0 0 -38.02 7.5 0c0.01,0.75 0.63,1.36 1.39,1.36l10.02 0c0.76,0 1.38,-0.61 1.39,-1.36l10.1 0z', 'pasa la encuesta a supervision dirigida telefonica', 'false', 'false','false','true','false','false'),
('UT_2023', 'no_sup_presencial', 'no_sup_dir', 'false', 'M19.99 2.62l10.02 0c0.77,0 1.39,0.63 1.39,1.39l0 0.15 7.69 0c1.32,0 2.41,1.09 2.41,2.41l0 17.77 -2.6 -2.59 0 -14.99 -7.5 0c-0.01,0.75 -0.63,1.36 -1.39,1.36l-10.02 0c-0.76,0 -1.38,-0.61 -1.39,-1.36l-6.33 0 -2.37 -2.38c0.31,-0.14 0.65,-0.22 1.01,-0.22l7.69 0 0 -0.15c0,-0.76 0.62,-1.39 1.39,-1.39zm3.22 22.43l2.54 2.53 -3.86 3.87 0 12.61 19.54 0 0 -0.79 -30.33 -30.34 0 31.85 5.81 0c0.13,0.97 0.54,1.86 1.18,2.6l-7.18 0c-1.33,0 -2.41,-1.08 -2.41,-2.41l0 -34.63 -4.82 -4.83c-1.21,-1.2 0.63,-3.04 1.84,-1.83 13.9,13.9 27.81,27.81 41.71,41.71 1.21,1.22 -0.63,3.05 -1.84,1.84l-1.04 -1.04c-0.66,0.91 -1.71,1.46 -2.84,1.46l-19.7 0c-0.97,0 -1.85,-0.4 -2.48,-1.03l-0.13 -0.15c-0.56,-0.62 -0.9,-1.44 -0.9,-2.33l0 -9.11 -0.33 0.33c-0.7,0.7 -1.84,0.7 -2.54,0 -0.7,-0.7 -0.7,-1.83 0,-2.53l7.78 -7.78zm3.68 -3.68l3.54 -3.54c0.7,-0.7 1.83,-0.7 2.53,0l15 15c0.7,0.7 0.7,1.83 0,2.53 -0.7,0.7 -1.84,0.7 -2.54,0l-0.4 -0.4 0 4.55 -3.59 -3.59 0 -4.54 -9.74 -9.74 -2.27 2.27 -2.53 -2.54z', 'revierte preparación de supervision dirigida presencial', 'false', 'false','false','true','false','false'),
('UT_2023', 'no_sup_telef', 'no_sup_tel', 'false', 'M19.99 2.62l10.02 0c0.77,0 1.39,0.63 1.39,1.39l0 0.15 7.69 0c0.65,0 1.26,0.27 1.7,0.71 0.43,0.44 0.71,1.04 0.71,1.7l0 29.42 -2.6 -2.6 0 -26.63 -7.5 0c-0.01,0.75 -0.63,1.36 -1.39,1.36l-10.02 0c-0.76,0 -1.38,-0.61 -1.39,-1.36l-6.33 0 -2.37 -2.37c0.31,-0.15 0.65,-0.23 1.01,-0.23l7.69 0 0 -0.15c0,-0.76 0.62,-1.39 1.39,-1.39zm15.99 35.2l2.92 -0.75 -9.64 -9.65c0.07,-1.34 0.42,-2.5 1.34,-3.02 0.5,-0.29 0.86,-0.29 1.4,-0.35 0.53,-0.06 0.93,-0.16 1.44,-0.24 2.6,-0.41 3.11,-2.19 3.03,-4.68 -0.05,-1.44 0.08,-4.9 -1.71,-5.45 -0.95,-0.29 -1.85,0.1 -2.91,0.24 -3.03,0.39 -5.89,2.69 -7.24,5.88 -0.31,0.74 -0.55,1.49 -0.73,2.24 -6.12,-6.12 -12.24,-12.24 -18.36,-18.36 -0.51,-0.51 -1.33,-0.51 -1.84,0 -0.51,0.5 -0.51,1.33 0,1.83l4.82 4.83 0 34.63c0,0.66 0.27,1.26 0.71,1.7 0.44,0.44 1.04,0.71 1.7,0.71l19.1 0c-1.02,-0.72 -1.93,-1.6 -2.73,-2.6l-16.18 0 0 -31.85 12.32 12.32c-0.14,2.38 0.15,4.67 0.47,6.63 1.02,6.31 4.08,15.55 12.16,15.93 1.22,0.06 1.82,-0.13 2.9,-0.35 0.96,-0.2 2.11,-0.27 2.64,-1.24 0.36,-0.67 0.23,-1.76 -0.05,-2.84l3.85 3.85c0.51,0.51 1.33,0.51 1.84,0 0.51,-0.5 0.51,-1.33 0,-1.84l-8.33 -8.32 -4.59 1.18c-2.88,0.79 -4.01,-3.6 -4.37,-5.22 -0.08,-0.41 -0.2,-0.95 -0.32,-1.57l6.36 6.36z', 'revierte preparación de supervision dirigida telefonica', 'false', 'false','false','true','false','false');

insert into "estados_acciones" ("operativo", "estado", "eaccion", "condicion", "estado_destino", "eaccion_direccion", "nombre_procedure", "nombre_wscreen") values
('UT_2023', '0D', 'sup_presencial', 'habilitada and estado = ''0D'' and coalesce(te.supervision_dirigida,-10) <> 1 and te.dominio <> 5', '0D', 'avance', 'encuesta_supervisar_presencial', null),
('UT_2023', '0D', 'sup_telef', 'habilitada and estado = ''0D'' and coalesce(te.supervision_dirigida,-10) <> 2 and te.dominio <> 5', '0D', 'avance', 'encuesta_supervisar_telefonica', null),
('UT_2023', '0D', 'no_sup_presencial', 'habilitada and estado = ''0D'' and te.supervision_dirigida = 1', '0D', 'retroceso', 'encuesta_no_supervisar', null),
('UT_2023', '0D', 'no_sup_telef', 'habilitada and estado = ''0D'' and te.supervision_dirigida = 2', '0D', 'retroceso', 'encuesta_no_supervisar', null);

update tem te set t.tarea_proxima = 'finc' 
from (select * 
        from tareas_tem tt
        where operativo = 'UT_2023' and verificado = '1') as tt
where te.operativo = tt.operativo and te.enc = tt.enc and te.tarea_actual = tt.tarea and  tarea_proxima is null;