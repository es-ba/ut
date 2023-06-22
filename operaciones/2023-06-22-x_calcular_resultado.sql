----ya lo corrimos en produc
set role ut2023_owner ; --poner el usuario que corresponda según el entorno


-- FUNCTION: base.xcalcular_resultado_trg()

-- DROP FUNCTION IF EXISTS base.xcalcular_resultado_trg();

CREATE OR REPLACE FUNCTION base.xcalcular_resultado_trg()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
declare
  vresultado       text;
begin
    select  case when new.rea=1 then 'efectiva'  when new.rea=3 then 'pendiente' when new.rea=4 then 'mixta' when (new.rea=2 and new.norea is not null) then (select grupo from no_rea where new.norea=no_rea::integer )  else null end  into vresultado
      from tem
      where operativo='UT_2023' and enc=new.enc;
    
    new.resultado= vresultado ;
    return new; 
end;
$BODY$;

ALTER FUNCTION base.xcalcular_resultado_trg()
    OWNER TO ut2023_owner;


-- Trigger: xcalcular_resultado_trg

-- DROP TRIGGER IF EXISTS xcalcular_resultado_trg ON base.tem;

CREATE TRIGGER xcalcular_resultado_trg
    BEFORE INSERT OR UPDATE OF rea, norea
    ON base.tem
    FOR EACH ROW
    EXECUTE FUNCTION base.xcalcular_resultado_trg();
    
----
----script inicial  para los casos que ya están cargados -- lo ejecutamos en producción el 22-06-2023
set search_path=base;
update base.tem t set resultado=x.vresultado
 from (
      select operativo, enc, rea, norea,case when rea=1 then 'efectiva'  when rea=3 then 'pendiente' when rea=4 then 'mixta' when (rea=2 and norea is not null) then (select grupo from base.no_rea where norea=no_rea::integer )  else null end  as vresultado
        from base.tem
        where operativo='UT_2023' and rea is not null
       )x
 where x.operativo=t.operativo and x.enc=t.enc and t.habilitada and t.rea=x.rea;

    