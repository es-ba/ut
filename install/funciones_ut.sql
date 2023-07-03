--set role ut2023_owner;
--set search_path=base;

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
                and (hasta>p_desde and hasta<=p_hasta or desde<p_hasta and desde>=p_desde or desde>=p_desde and hasta<=p_hasta)
        ;     
$BODY$;
