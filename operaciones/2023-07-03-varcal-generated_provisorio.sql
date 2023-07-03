set role ut2023_admin;
--CAMBIAR ROL  de acuerdo al entorno
-- REEMPLAZAR TAMBIENA EL OWNER

do $SQL_DUMP$
 begin
----
set search_path = base, comun;
----
drop table if exists "ut_2023_actividades_calculada" cascade;
drop table if exists "ut_2023_personas_sup_calculada";
drop table if exists "ut_2023_personas_calculada";
drop table if exists "ut_2023_hogares_sup_calculada";
drop table if exists "ut_2023_hogares_calculada";
drop table if exists "ut_2023_visitas_sup_calculada";
drop table if exists "ut_2023_visitas_calculada";
drop table if exists "ut_2023_viviendas_calculada";
drop table if exists "ut_2023_tem_calculada";
----


--
-- lines
create table "ut_2023_actividades_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "persona" bigint, 
  "renglon" bigint,
  "desde_min" bigint, 
  "hasta_min" bigint, 
  "cant_minutos_epi" bigint,
  "tiempo_epi" interval,
  "d_cant_codigo_pegado" bigint, 
  "d_cant_cod_simult" bigint
, primary key ("operativo", "vivienda", "hogar", "persona", "renglon")
);
grant select, insert, update, references on "ut_2023_actividades_calculada" to ut2023_admin;
grant all on "ut_2023_actividades_calculada" to ut2023_owner;



create table "ut_2023_hogares_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint,
  "cant_per" bigint, 
  "cant_jefes" bigint, 
  "cant_conyuges" bigint, 
  "edadjefe" bigint, 
  "p5b_jefe" bigint, 
  "sexojefe" bigint, 
  "sitconyjefe" bigint,
  "cant_per_0a13" bigint, 
  "cant_per_14a64_no_selec" bigint, 
  "cant_per_65ymas_no_selec" bigint,
  "cant_per_dc1_1_no_selec" bigint 
, primary key ("operativo", "vivienda", "hogar")
);
grant select, insert, update, references on "ut_2023_hogares_calculada" to ut2023_admin;
grant all on "ut_2023_hogares_calculada" to ut2023_owner;



create table "ut_2023_hogares_sup_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint
, primary key ("operativo", "vivienda", "hogar")
);
grant select, insert, update, references on "ut_2023_hogares_sup_calculada" to ut2023_admin;
grant all on "ut_2023_hogares_sup_calculada" to ut2023_owner;



create table "ut_2023_personas_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "persona" bigint,
  "cant_cod_11" bigint, 
  "cant_cod_412" bigint, 
  "cant_cod_422" bigint, 
  "cant_cod_51" bigint, 
  "cant_cod_911" bigint, 
  "cant_cod_921" bigint, 
  "cant_cod_922" bigint, 
  "cant_cod_cuid_0a13" bigint, 
  "cant_cod_cuid_14a64" bigint, 
  "cant_cod_cuid_65ymas" bigint, 
  "cant_cod_cuid_disca" bigint, 
  "cant_reg_x_diario" bigint, 
  "edad_madre" bigint, 
  "edad_padre" bigint, 
  "edad_pareja" bigint, 
  "p4_madre" bigint, 
  "p4_padre" bigint, 
  "p4_pareja" bigint, 
  "p5_madre" bigint, 
  "p5_padre" bigint, 
  "p5_pareja" bigint, 
  "p5b_madre" bigint, 
  "p5b_padre" bigint, 
  "p5b_pareja" bigint, 
  "sexo_madre" bigint, 
  "sexo_padre" bigint, 
  "sexo_pareja" bigint
, primary key ("operativo", "vivienda", "hogar", "persona")
);
grant select, insert, update, references on "ut_2023_personas_calculada" to ut2023_admin;
grant all on "ut_2023_personas_calculada" to ut2023_owner;



create table "ut_2023_personas_sup_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "persona" bigint
, primary key ("operativo", "vivienda", "hogar", "persona")
);
grant select, insert, update, references on "ut_2023_personas_sup_calculada" to ut2023_admin;
grant all on "ut_2023_personas_sup_calculada" to ut2023_owner;



create table "ut_2023_tem_calculada" (
  "operativo" text, 
  "enc" text
, primary key ("operativo", "enc")
);
grant select, insert, update, references on "ut_2023_tem_calculada" to ut2023_admin;
grant all on "ut_2023_tem_calculada" to ut2023_owner;



create table "ut_2023_visitas_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "visita" bigint
, primary key ("operativo", "vivienda", "visita")
);
grant select, insert, update, references on "ut_2023_visitas_calculada" to ut2023_admin;
grant all on "ut_2023_visitas_calculada" to ut2023_owner;



create table "ut_2023_visitas_sup_calculada" (
  "operativo" text, 
  "vivienda" text, 
  "visita" bigint
, primary key ("operativo", "vivienda", "visita")
);
grant select, insert, update, references on "ut_2023_visitas_sup_calculada" to ut2023_admin;
grant all on "ut_2023_visitas_sup_calculada" to ut2023_owner;



create table "ut_2023_viviendas_calculada" (
  "operativo" text, 
  "vivienda" text,
  "cant_vis" bigint, 
  "cant_hog" bigint
, primary key ("operativo", "vivienda")
);
grant select, insert, update, references on "ut_2023_viviendas_calculada" to ut2023_admin;
grant all on "ut_2023_viviendas_calculada" to ut2023_owner;



-- conss
alter table "ut_2023_actividades_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_actividades_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_hogares_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_hogares_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_hogares_sup_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_hogares_sup_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_personas_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_personas_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_personas_sup_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_personas_sup_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_tem_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_tem_calculada" add constraint "enc<>''" check ("enc"<>'');
alter table "ut_2023_visitas_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_visitas_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_visitas_sup_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_visitas_sup_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "ut_2023_viviendas_calculada" add constraint "operativo<>''" check ("operativo"<>'');
alter table "ut_2023_viviendas_calculada" add constraint "vivienda<>''" check ("vivienda"<>'');
-- FKs
alter table "ut_2023_actividades_calculada" add constraint "ut_2023_actividades_calculada actividades REL" foreign key ("operativo", "vivienda", "hogar", "persona", "renglon") references "actividades" ("operativo", "vivienda", "hogar", "persona", "renglon")  on delete cascade on update cascade;
alter table "ut_2023_hogares_calculada" add constraint "ut_2023_hogares_calculada hogares REL" foreign key ("operativo", "vivienda", "hogar") references "hogares" ("operativo", "vivienda", "hogar")  on delete cascade on update cascade;
alter table "ut_2023_hogares_sup_calculada" add constraint "ut_2023_hogares_sup_calculada hogares_sup REL" foreign key ("operativo", "vivienda", "hogar") references "hogares_sup" ("operativo", "vivienda", "hogar")  on delete cascade on update cascade;
alter table "ut_2023_personas_calculada" add constraint "ut_2023_personas_calculada personas REL" foreign key ("operativo", "vivienda", "hogar", "persona") references "personas" ("operativo", "vivienda", "hogar", "persona")  on delete cascade on update cascade;
alter table "ut_2023_personas_sup_calculada" add constraint "ut_2023_personas_sup_calculada personas_sup REL" foreign key ("operativo", "vivienda", "hogar", "persona") references "personas_sup" ("operativo", "vivienda", "hogar", "persona")  on delete cascade on update cascade;
alter table "ut_2023_tem_calculada" add constraint "ut_2023_tem_calculada tem REL" foreign key ("operativo", "enc") references "tem" ("operativo", "enc")  on delete cascade on update cascade;
alter table "ut_2023_visitas_calculada" add constraint "ut_2023_visitas_calculada visitas REL" foreign key ("operativo", "vivienda", "visita") references "visitas" ("operativo", "vivienda", "visita")  on delete cascade on update cascade;
alter table "ut_2023_visitas_sup_calculada" add constraint "ut_2023_visitas_sup_calculada visitas_sup REL" foreign key ("operativo", "vivienda", "visita") references "visitas_sup" ("operativo", "vivienda", "visita")  on delete cascade on update cascade;
alter table "ut_2023_viviendas_calculada" add constraint "ut_2023_viviendas_calculada viviendas REL" foreign key ("operativo", "vivienda") references "viviendas" ("operativo", "vivienda")  on delete cascade on update cascade;
-- index
create index "ut_2023_actividades_calculada actividades IDX" ON "ut_2023_actividades_calculada" ("operativo", "vivienda", "hogar", "persona", "renglon");
create index "operativo,vivienda,hogar 4 ut_2023_hogares_calculada IDX" ON "ut_2023_hogares_calculada" ("operativo", "vivienda", "hogar");
create index "operativo,vivienda,hogar 4 ut_2023_hogares_sup_calculada IDX" ON "ut_2023_hogares_sup_calculada" ("operativo", "vivienda", "hogar");
create index "ut_2023_personas_calculada personas IDX" ON "ut_2023_personas_calculada" ("operativo", "vivienda", "hogar", "persona");
create index "ut_2023_personas_sup_calculada personas_sup IDX" ON "ut_2023_personas_sup_calculada" ("operativo", "vivienda", "hogar", "persona");
create index "operativo,enc 4 ut_2023_tem_calculada IDX" ON "ut_2023_tem_calculada" ("operativo", "enc");
create index "operativo,vivienda,visita 4 ut_2023_visitas_calculada IDX" ON "ut_2023_visitas_calculada" ("operativo", "vivienda", "visita");
create index "operativo,vivienda,visita 4 ut_2023_visitas_sup_calculada IDX" ON "ut_2023_visitas_sup_calculada" ("operativo", "vivienda", "visita");
create index "operativo,vivienda 4 ut_2023_viviendas_calculada IDX" ON "ut_2023_viviendas_calculada" ("operativo", "vivienda");
-- policies

----
            INSERT INTO "ut_2023_viviendas_calculada" ("operativo","vivienda") 
              SELECT "operativo","vivienda" FROM "viviendas";

            INSERT INTO "ut_2023_tem_calculada" ("operativo","enc") 
              SELECT "operativo","enc" FROM "tem";

            INSERT INTO "ut_2023_visitas_calculada" ("operativo","vivienda","visita") 
              SELECT "operativo","vivienda","visita" FROM "visitas";

            INSERT INTO "ut_2023_visitas_sup_calculada" ("operativo","vivienda","visita") 
              SELECT "operativo","vivienda","visita" FROM "visitas_sup";

            INSERT INTO "ut_2023_hogares_calculada" ("operativo","vivienda","hogar") 
              SELECT "operativo","vivienda","hogar" FROM "hogares";

            INSERT INTO "ut_2023_hogares_sup_calculada" ("operativo","vivienda","hogar") 
              SELECT "operativo","vivienda","hogar" FROM "hogares_sup";

            INSERT INTO "ut_2023_personas_calculada" ("operativo","vivienda","hogar","persona") 
              SELECT "operativo","vivienda","hogar","persona" FROM "personas";

            INSERT INTO "ut_2023_personas_sup_calculada" ("operativo","vivienda","hogar","persona") 
              SELECT "operativo","vivienda","hogar","persona" FROM "personas_sup";

            INSERT INTO "ut_2023_actividades_calculada" ("operativo","vivienda","hogar","persona","renglon") 
              SELECT "operativo","vivienda","hogar","persona","renglon" FROM "actividades";
----
CREATE OR REPLACE FUNCTION base.gen_fun_var_calc() RETURNS TEXT
  LANGUAGE PLPGSQL AS
$GENERATOR$
declare
  v_sql text:=$THE_FUN$
CREATE OR REPLACE FUNCTION update_varcal_por_encuesta("p_operativo" text, "p_id_caso" text) RETURNS TEXT
  LANGUAGE PLPGSQL AS
$BODY$
BEGIN
-- Cada vez que se actualizan las variables calculadas, previamente se deben insertar los registros que no existan (on conflict do nothing)
-- de las tablas base (solo los campos pks), sin filtrar por p_id_caso para update_varcal o con dicho filtro para update_varcal_por_encuesta
    INSERT INTO "ut_2023_viviendas_calculada" ("operativo","vivienda") 
      SELECT "operativo","vivienda" FROM "viviendas" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_tem_calculada" ("operativo","enc") 
      SELECT "operativo","enc" FROM "tem" WHERE operativo=p_operativo AND "enc"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_visitas_calculada" ("operativo","vivienda","visita") 
      SELECT "operativo","vivienda","visita" FROM "visitas" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_visitas_sup_calculada" ("operativo","vivienda","visita") 
      SELECT "operativo","vivienda","visita" FROM "visitas_sup" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_hogares_calculada" ("operativo","vivienda","hogar") 
      SELECT "operativo","vivienda","hogar" FROM "hogares" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_hogares_sup_calculada" ("operativo","vivienda","hogar") 
      SELECT "operativo","vivienda","hogar" FROM "hogares_sup" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_personas_calculada" ("operativo","vivienda","hogar","persona") 
      SELECT "operativo","vivienda","hogar","persona" FROM "personas" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_personas_sup_calculada" ("operativo","vivienda","hogar","persona") 
      SELECT "operativo","vivienda","hogar","persona" FROM "personas_sup" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
    INSERT INTO "ut_2023_actividades_calculada" ("operativo","vivienda","hogar","persona","renglon") 
      SELECT "operativo","vivienda","hogar","persona","renglon" FROM "actividades" WHERE operativo=p_operativo AND "vivienda"=p_id_caso ON CONFLICT DO NOTHING;
----
    UPDATE ut_2023_actividades_calculada
        SET 
            desde_min = hora_a_minutos(actividades.desde),
            hasta_min = hora_a_minutos(actividades.hasta),
            tiempo_epi = actividades.hasta - actividades.desde,
            d_cant_codigo_pegado = cant_codigo_pegado_diario(null2zero(actividades.operativo), null2zero(actividades.vivienda), null2zero(actividades.hogar), null2zero(actividades.persona), null2zero(actividades.codigo), actividades.hasta),
            d_cant_cod_simult = cant_codigos_simultaneos(null2zero(actividades.operativo), null2zero(actividades.vivienda), null2zero(actividades.hogar), null2zero(actividades.persona), null2zero(actividades.codigo), actividades.desde, actividades.hasta)
        FROM "actividades"  
        WHERE "actividades"."operativo"="ut_2023_actividades_calculada"."operativo" AND "actividades"."vivienda"="ut_2023_actividades_calculada"."vivienda" AND "actividades"."hogar"="ut_2023_actividades_calculada"."hogar" AND "actividades"."persona"="ut_2023_actividades_calculada"."persona" AND "actividades"."renglon"="ut_2023_actividades_calculada"."renglon" AND "actividades"."operativo"=p_operativo AND "actividades"."vivienda"=p_id_caso;
    UPDATE ut_2023_actividades_calculada
        SET 
            cant_minutos_epi = null2zero(ut_2023_actividades_calculada.hasta_min) - null2zero(ut_2023_actividades_calculada.desde_min)
        FROM "actividades" 
        WHERE "actividades"."operativo"="ut_2023_actividades_calculada"."operativo" AND "actividades"."vivienda"="ut_2023_actividades_calculada"."vivienda" AND "actividades"."hogar"="ut_2023_actividades_calculada"."hogar" AND "actividades"."persona"="ut_2023_actividades_calculada"."persona" AND "actividades"."renglon"="ut_2023_actividades_calculada"."renglon" AND "actividades"."operativo"=p_operativo AND "actividades"."vivienda"=p_id_caso;

    UPDATE ut_2023_hogares_calculada
        SET 
            cant_per = personas_agg.cant_per,
            cant_jefes = personas_agg.cant_jefes,
            cant_conyuges = personas_agg.cant_conyuges,
            cant_per_0a13 = psersona_agg.cant_per_0a13,
            cant_per_14a64_no_selec = personas_agg.cant_per_14a64_no_selec,
            cant_per_65ymas_no_selec = personas_agg.cant_per_65ymas_no_selec,
            cant_per_dc1_1_no_selec = personas_agg.cant_per_dc1_1_no_selec
        FROM "hogares"  
            ,LATERAL (
            SELECT
                count(nullif(true,false)) as cant_per,
                count(nullif(CASE WHEN "personas"."p4"=1 THEN true ELSE NULL END,false)) as cant_jefes,
                count(nullif(CASE WHEN "personas"."p4"=2 THEN true ELSE NULL END,false)) as cant_conyuges,
                count(nullif(CASE WHEN "personas"."edad">=0 and "personas"."edad"<=13 THEN true ELSE NULL END,false)) as cant_per_0a13,
                count(nullif(CASE WHEN "personas"."edad">14 and "personas"."edad"<=64 and "personas"."persona"<>"hogares"."cr_num_miembro" THEN true ELSE NULL END,false)) as cant_per_14a64_no_selec,
                count(nullif(CASE WHEN "personas"."edad">=65 and "personas"."edad"<=130 and "personas"."persona"<>"hogares"."cr_num_miembro" THEN true ELSE NULL END,false)) as cant_per_65ymas_no_selec,
                count(nullif(CASE WHEN "personas"."dc1"=1 and "personas"."persona"<>"hogares"."cr_num_miembro" THEN true ELSE NULL END,false)) as cant_per_dc1_1_no_selec
            FROM "personas" JOIN "ut_2023_personas_calculada" using ("operativo","vivienda","hogar","persona")
                WHERE "hogares"."operativo"="personas"."operativo" 
                AND "hogares"."vivienda"="personas"."vivienda" 
                AND "hogares"."hogar"="personas"."hogar"
            ) as personas_agg
        WHERE "hogares"."operativo"="ut_2023_hogares_calculada"."operativo" 
            AND "hogares"."vivienda"="ut_2023_hogares_calculada"."vivienda" 
            AND "hogares"."hogar"="ut_2023_hogares_calculada"."hogar" 
            AND "hogares"."operativo"=p_operativo AND "hogares"."vivienda"=p_id_caso;

    UPDATE ut_2023_personas_calculada
      SET 
            edad_padre = padre.edad,
            sexo_padre = padre.sexo,
            p4_padre = padre.p4,
            p5_padre = padre.p5,
            p5b_padre = padre.p5b
    FROM personas inner join hogares using (operativo,vivienda,hogar) inner join viviendas using (operativo, vivienda) inner join ut_2023_viviendas_calculada using (operativo, vivienda)
        LEFT JOIN (
            SELECT operativo, vivienda, hogar, persona, padre.edad, padre.sexo, padre.p4, padre.p5, padre.p5b
              FROM personas padre
              --WHERE padre.persona=personas.p6a
        ) padre ON padre.operativo=personas.operativo AND padre.vivienda=personas.vivienda AND padre.hogar=personas.hogar and padre.persona=personas.p6a
    WHERE "personas"."operativo"="ut_2023_personas_calculada"."operativo" AND "personas"."vivienda"="ut_2023_personas_calculada"."vivienda" 
      AND "personas"."hogar"="ut_2023_personas_calculada"."hogar" AND "personas"."persona"="ut_2023_personas_calculada"."persona" 
      AND "personas"."operativo"=p_operativo AND "personas"."vivienda"=p_id_caso;

    UPDATE ut_2023_personas_calculada
      SET 
            edad_madre = madre.edad,
            sexo_madre = madre.sexo,
            p4_madre = madre.p4,
            p5_madre = madre.p5,
            p5b_madre = madre.p5b
    FROM personas inner join hogares using (operativo,vivienda,hogar) inner join viviendas using (operativo, vivienda) inner join ut_2023_viviendas_calculada using (operativo, vivienda)
        LEFT JOIN (
            SELECT operativo, vivienda, hogar, persona, madre.edad, madre.sexo, madre.p4, madre.p5, madre.p5b
              FROM personas madre
              --WHERE madre.persona=personas.p6a           
        ) madre ON madre.operativo=personas.operativo AND madre.vivienda=personas.vivienda AND madre.hogar=personas.hogar and madre.persona=personas.p6b
    WHERE "personas"."operativo"="ut_2023_personas_calculada"."operativo" AND "personas"."vivienda"="ut_2023_personas_calculada"."vivienda"
      AND "personas"."hogar"="ut_2023_personas_calculada"."hogar" AND "personas"."persona"="ut_2023_personas_calculada"."persona"  
      AND "personas"."operativo"=p_operativo AND "personas"."vivienda"=p_id_caso;

    UPDATE ut_2023_personas_calculada
      SET 
            edad_pareja = pareja.edad,
            sexo_pareja = pareja.sexo,
            p4_pareja = pareja.p4,
            p5_pareja = pareja.p5,
            p5b_pareja = pareja.p5b
    FROM personas inner join hogares using (operativo,vivienda,hogar) inner join viviendas using (operativo, vivienda) inner join ut_2023_viviendas_calculada using (operativo, vivienda)
        LEFT JOIN (
            SELECT operativo, vivienda, hogar, persona, pareja.edad, pareja.sexo, pareja.p4, pareja.p5, pareja.p5b
              FROM personas pareja
        ) pareja ON pareja.operativo=personas.operativo AND pareja.vivienda=personas.vivienda AND pareja.hogar=personas.hogar and pareja.persona=personas.p5b
    WHERE "personas"."operativo"="ut_2023_personas_calculada"."operativo" AND "personas"."vivienda"="ut_2023_personas_calculada"."vivienda"
      AND "personas"."hogar"="ut_2023_personas_calculada"."hogar" AND "personas"."persona"="ut_2023_personas_calculada"."persona"  
      AND "personas"."operativo"=p_operativo AND "personas"."vivienda"=p_id_caso;




    UPDATE ut_2023_hogares_calculada
      SET 
            edadjefe = respondiente.edad,
            sexojefe = respondiente.sexo,
            sitconyjefe = respondiente.p5,
            p5b_jefe = respondiente.p5b
    FROM hogares inner join viviendas using (operativo, vivienda) inner join ut_2023_viviendas_calculada using (operativo, vivienda)
        LEFT JOIN (
            SELECT operativo, vivienda, hogar, persona, respondiente.edad, respondiente.sexo, respondiente.p5, respondiente.p5b
              FROM personas respondiente
              WHERE respondiente.persona=1
        ) respondiente ON respondiente.operativo=hogares.operativo AND respondiente.vivienda=hogares.vivienda AND respondiente.hogar=hogares.hogar  
    WHERE "hogares"."operativo"="ut_2023_hogares_calculada"."operativo" AND "hogares"."vivienda"="ut_2023_hogares_calculada"."vivienda" AND "hogares"."hogar"="ut_2023_hogares_calculada"."hogar" 
      AND "hogares"."operativo"=p_operativo AND "hogares"."vivienda"=p_id_caso;

          UPDATE ut_2023_personas_calculada
            SET 
              cant_cod_11 = actividades_agg.cant_cod_11,
                cant_cod_412 = actividades_agg.cant_cod_412,
                cant_cod_422 = actividades_agg.cant_cod_422,
                cant_cod_51 = actividades_agg.cant_cod_51,
                cant_cod_911 = actividades_agg.cant_cod_911,
                cant_cod_921 = actividades_agg.cant_cod_921,
                cant_cod_922 = actividades_agg.cant_cod_922,
                cant_cod_cuid_0a13 = actividades_agg.cant_cod_cuid_0a13,
                cant_cod_cuid_14a64 = actividades_agg.cant_cod_cuid_14a64,
                cant_cod_cuid_65ymas = actividades_agg.cant_cod_cuid_65ymas,
                cant_cod_cuid_disca = actividades_agg.cant_cod_cuid_disca,
                cant_reg_x_diario = actividades_agg.cant_reg_x_diario
            FROM "personas"  
              ,LATERAL (
                SELECT
                count(nullif(CASE WHEN "actividades"."codigo"=11 THEN true ELSE NULL END,false)) as cant_cod_11,
                count(nullif(CASE WHEN "actividades"."codigo"=412 THEN true ELSE NULL END,false)) as cant_cod_412,
                count(nullif(CASE WHEN "actividades"."codigo"=422 THEN true ELSE NULL END,false)) as cant_cod_422,
                count(nullif(CASE WHEN "actividades"."codigo"=51 THEN true ELSE NULL END,false)) as cant_cod_51,
                count(nullif(CASE WHEN "actividades"."codigo"=911 THEN true ELSE NULL END,false)) as cant_cod_911,
                count(nullif(CASE WHEN "actividades"."codigo"=921 THEN true ELSE NULL END,false)) as cant_cod_921,
                count(nullif(CASE WHEN "actividades"."codigo"=922 THEN true ELSE NULL END,false)) as cant_cod_922,
                count(nullif(CASE WHEN "actividades"."codigo"=411 or "actividades"."codigo"=412 or "actividades"."codigo"=413 or "actividades"."codigo"=414 or "actividades"."codigo"=419 THEN true ELSE NULL END,false)) as cant_cod_cuid_0a13,
                count(nullif(CASE WHEN "actividades"."codigo"=421 or "actividades"."codigo"=422 or "actividades"."codigo"=423 or "actividades"."codigo"=429 THEN true ELSE NULL END,false)) as cant_cod_cuid_14a64,
                count(nullif(CASE WHEN "actividades"."codigo"=431 or "actividades"."codigo"=432 or "actividades"."codigo"=433 or "actividades"."codigo"=439 THEN true ELSE NULL END,false)) as cant_cod_cuid_65ymas,
                count(nullif(CASE WHEN "actividades"."codigo"=441 or "actividades"."codigo"=442 or "actividades"."codigo"=443 or "actividades"."codigo"=449 THEN true ELSE NULL END,false)) as cant_cod_cuid_disca,
                count(nullif(true,false)) as cant_reg_x_diario
            FROM "actividades" JOIN "ut_2023_actividades_calculada" using ("operativo","vivienda","hogar","persona","renglon")
                WHERE "personas"."operativo"="actividades"."operativo" AND "personas"."vivienda"="actividades"."vivienda" AND "personas"."hogar"="actividades"."hogar" AND "personas"."persona"="actividades"."persona"
              ) as actividades_agg
            WHERE "personas"."operativo"="ut_2023_personas_calculada"."operativo" AND "personas"."vivienda"="ut_2023_personas_calculada"."vivienda" AND "personas"."hogar"="ut_2023_personas_calculada"."hogar" AND "personas"."persona"="ut_2023_personas_calculada"."persona" AND "personas"."operativo"=p_operativo AND "personas"."vivienda"=p_id_caso;


    UPDATE ut_2023_viviendas_calculada
        SET 
            cant_vis = visitas_agg.cant_vis,
            cant_hog = hogares_agg.cant_hog
        FROM "viviendas"  
            ,LATERAL (
            SELECT
                count(nullif(true,false)) as cant_vis
                FROM "visitas" JOIN "ut_2023_visitas_calculada" using ("operativo","vivienda","visita")
                WHERE "viviendas"."vivienda"="visitas"."vivienda" 
                AND "viviendas"."operativo"="visitas"."operativo"
            ) as visitas_agg
            ,LATERAL (
            SELECT
                count(nullif(true,false)) as cant_hog
                FROM "hogares" JOIN "ut_2023_hogares_calculada" using ("operativo","vivienda","hogar")
                WHERE "viviendas"."operativo"="hogares"."operativo" AND "viviendas"."vivienda"="hogares"."vivienda"
            ) as hogares_agg
        WHERE "viviendas"."operativo"="ut_2023_viviendas_calculada"."operativo" 
            AND "viviendas"."vivienda"="ut_2023_viviendas_calculada"."vivienda" 
            AND "viviendas"."operativo"=p_operativo AND "viviendas"."vivienda"=p_id_caso;


----
  RETURN 'OK';
END;
$BODY$;
$THE_FUN$;
begin 
  -- TODO: hacer este reemplazo en JS
  execute v_sql;
  execute replace(replace(regexp_replace(replace(
    v_sql,
    $$update_varcal_por_encuesta("p_operativo" text, "p_id_caso" text) RETURNS TEXT$$, $$update_varcal("p_operativo" text) RETURNS TEXT$$),
    $$(.* )".*"\."vivienda"=p_id_caso(.*)$$, $$\1TRUE\2$$,'gm'),
    $$"enc"=p_id_caso$$, $$TRUE$$),
    $$"vivienda"=p_id_caso$$, $$TRUE$$);
  return '2GENERATED';
end;
$GENERATOR$;        
----
perform gen_fun_var_calc();
----

UPDATE operativos SET calculada=now()::timestamp(0) WHERE operativo='UT_2023';
UPDATE tabla_datos SET generada=now()::timestamp(0) WHERE operativo='UT_2023' AND tipo='calculada';
----
end;
$SQL_DUMP$;--- boton calcular generado: Fri Jun 23 2023 13:30:45 GMT-0300 (hora estándar de Argentina)

select update_varcal('UT_2023');


