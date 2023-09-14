--set role ut2023_owner;
--set search_path=base;

-- para generar null2zero para tipo intervalo. Por el momento no reemplazar con neutro
select generate_generics('interval','null');

-- DROP FUNCTION IF EXISTS existe_codigo_pegado_diario(text, text, integer, integer, integer, text);

CREATE OR REPLACE FUNCTION cant_codigo_pegado_diario(
    p_ope text,
	p_viv text,
	p_hog bigint,
	p_per bigint,
	p_codigo bigint,
	p_hasta interval)
    RETURNS bigint
    LANGUAGE 'sql'
    STABLE
AS $BODY$
        select count(distinct codigo)
            from actividades  
            where operativo= p_ope and vivienda=p_viv and hogar=p_hog and persona=p_per 
                and codigo=p_codigo and desde=p_hasta
        ;     
$BODY$;


-- DROP FUNCTION IF EXISTS cant_codigos_simultaneos(text, integer, integer, integer, text, text);
CREATE OR REPLACE FUNCTION cant_codigos_simultaneos(
    p_ope text,    
	p_viv text,
	p_hog bigint,
	p_per bigint,
	p_codigo bigint,
	p_desde interval,
	p_hasta interval)
    RETURNS bigint
    LANGUAGE 'sql'
    STABLE 
AS $BODY$
        select count(distinct codigo)
            from actividades
            where operativo= p_ope and vivienda=p_viv and hogar=p_hog and persona=p_per and codigo is distinct from p_codigo
                and (hasta>p_desde and hasta<=p_hasta or desde<p_hasta and desde>=p_desde or desde>=p_desde and hasta<=p_hasta
                or desde<=p_desde and hasta>=p_hasta)
        ;     
$BODY$;

CREATE OR REPLACE FUNCTION cant_simultaneidad_por_intervalos(
    p_ope text,    
	p_viv text,
	p_hog bigint,
	p_per bigint,
	p_codigo bigint,
	p_codigo2 bigint,
	p_desde interval,
	p_hasta interval)
    RETURNS bigint
    LANGUAGE 'sql'
    STABLE
AS $BODY$
         select count(1)
            from simultaneidades_vw s  
            where vivienda=p_viv and hogar=p_hog and persona=p_per and cant_activ>1 and 
                 ((cota_min>=comun.hora_a_minutos(p_desde) and cota_min<=comun.hora_a_minutos(p_hasta)) or
                        (comun.hora_a_minutos(p_desde)<=cota_min_sup and cota_min_sup<=comun.hora_a_minutos(p_hasta))) and
                ((p_codigo is distinct from p_codigo2 and p_codigo = any(codigos_ar) and p_codigo2= any( codigos_ar)) or 
                 (p_codigo=p_codigo2  and array_length(array_positions(codigos_ar,p_codigo),1)>1))
          ;     
$BODY$;

CREATE OR REPLACE FUNCTION cant_simultaneidad_por_intervalos_mismo_codigo(
    p_ope text,    
	p_viv text,
	p_hog bigint,
	p_per bigint,
	p_codigo bigint,
	p_desde interval,
	p_hasta interval)
    RETURNS bigint
    LANGUAGE 'sql'
    STABLE
AS $BODY$
  select cant_simultaneidad_por_intervalos(p_ope,p_viv,p_hog,p_per, p_codigo,p_codigo,p_desde,p_hasta)
$BODY$;
