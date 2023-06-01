create table "viviendas" (
  "operativo" text, 
  "vivienda" text, 
  "vdominio" bigint, 
  "obs_re" text, 
  "total_vis" bigint, 
  "soporte" bigint, 
  "entreav" bigint, 
  "identif" bigint, 
  "habita" bigint, 
  "construc" bigint, 
  "razon_viv" bigint, 
  "razon2_2" bigint, 
  "razon2_6" bigint, 
  "razon3" text, 
  "resid_hog" bigint, 
  "razon_hog" bigint, 
  "razon2_1" bigint, 
  "razon2_3" bigint, 
  "razon2_5" bigint, 
  "razon_9v" bigint, 
  "contacto" bigint, 
  "v1" bigint, 
  "total_h" bigint, 
  "s1a1_obs_sup" text, 
  "datos_personal_sup" text, 
  "total_vis_sup" bigint, 
  "soporte_sup" bigint, 
  "modo_sup" bigint, 
  "confir_tel_sup" bigint, 
  "domicilio_sup" text, 
  "confir_dom_sup" bigint, 
  "identifico" bigint, 
  "sp1_sup" bigint, 
  "sp2_sup" bigint, 
  "razon2_1_sup" bigint, 
  "razon2_2_sup" bigint, 
  "razon2_3_sup" bigint, 
  "razon2_4_sup" bigint, 
  "razon2_5_sup" bigint, 
  "razon2_6_sup" bigint, 
  "razon3_sup" text, 
  "razon_9_1_sup" bigint, 
  "sp3_sup" bigint, 
  "total_h_sup" bigint, 
  "consistido" timestamp
, primary key ("operativo", "vivienda")
);
grant select, insert, update, delete, references on "viviendas" to ut_admin;
grant all on "viviendas" to ut_owner;



create table "visitas" (
  "operativo" text, 
  "vivienda" text, 
  "visita" bigint, 
  "rol" text, 
  "per" bigint, 
  "usu" text, 
  "fecha" text, 
  "hora" text, 
  "anotacion" text
, primary key ("operativo", "vivienda", "visita")
);
grant select, insert, update, delete, references on "visitas" to ut_admin;
grant all on "visitas" to ut_owner;



create table "hogares" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "obs_s1" text, 
  "entrea" bigint, 
  "f_realiz_o" date, 
  "los_nombres" text, 
  "total_m" bigint, 
  "respond" bigint, 
  "nombrer" text, 
  "sorteo" bigint, 
  "tp" bigint, 
  "cr_num_miembro" bigint, 
  "msnombre" text, 
  "v2" bigint, 
  "v2_esp" text, 
  "h2" bigint, 
  "h2_esp" text, 
  "h3" bigint, 
  "h20a_1" bigint, 
  "h20a_2" bigint, 
  "h20a_5" bigint, 
  "h20a_20" bigint, 
  "h20a_21" bigint, 
  "h20a_12" bigint, 
  "h20a_11" bigint, 
  "h20a_14" bigint, 
  "h20a_14_esp" text, 
  "it1" bigint, 
  "it2" bigint, 
  "uh12" bigint, 
  "uh13_h" bigint, 
  "uh13_min" bigint, 
  "uh14_1" bigint, 
  "uh14_2" bigint, 
  "uh14_3" bigint, 
  "uh14_4" bigint, 
  "uh14_4_esp" text, 
  "uh15" bigint, 
  "uh15_a" bigint, 
  "uh15_b_1" bigint, 
  "uh15_b_2" bigint, 
  "uh15_b_3" bigint, 
  "uh15_b_4" bigint, 
  "uh15_b_5" bigint, 
  "uh15_b_6" bigint, 
  "uh15_b_7" bigint, 
  "uh15_b_7_esp" text, 
  "uh15_c" bigint, 
  "uh15_d" bigint, 
  "uh15_e_1" bigint, 
  "uh15_e_2" bigint, 
  "uh15_e_3" bigint, 
  "uh15_e_4" bigint, 
  "uh15_e_5" bigint, 
  "uh15_e_6" bigint, 
  "uh15_e_7" bigint, 
  "uh15_f_7_esp" text, 
  "uh17" bigint, 
  "uh17_a" bigint, 
  "uh17_b" bigint, 
  "ut7_esp" text, 
  "tel1" text, 
  "tel2" text, 
  "razon1" bigint, 
  "razon2_7" bigint, 
  "razon2_8" bigint, 
  "razon2_9" bigint
, primary key ("operativo", "vivienda", "hogar")
);
grant select, insert, update, delete, references on "hogares" to ut_admin;
grant all on "hogares" to ut_owner;



create table "personas" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "persona" bigint, 
  "nombre" text, 
  "sexo" bigint, 
  "p2b" bigint, 
  "p2b_6_esp" text, 
  "edad" bigint, 
  "p4" bigint, 
  "lp" bigint, 
  "l0" text, 
  "p5" bigint, 
  "p5b" bigint, 
  "p6a" bigint, 
  "p6b" bigint, 
  "t1a" bigint, 
  "t3a" bigint, 
  "t9a" bigint, 
  "t29b" bigint, 
  "t44a" bigint, 
  "t46a" bigint, 
  "t51a" bigint, 
  "sn1b_1" bigint, 
  "sn1b_1_esp" text, 
  "sn1b_7" bigint, 
  "sn1b_7_esp" text, 
  "sn1b_2" bigint, 
  "sn1b_2_esp" text, 
  "sn1b_3" bigint, 
  "sn1b_3_esp" text, 
  "sn1b_4" bigint, 
  "sn1b_4_esp" text, 
  "sn1b_5" bigint, 
  "m1" bigint, 
  "m1_esp2" text, 
  "m1_esp3" text, 
  "m1_esp4" text, 
  "e2" bigint, 
  "e6a" bigint, 
  "e2t_h" bigint, 
  "e2t_min" bigint, 
  "e12a" bigint, 
  "e13" bigint, 
  "dc1" bigint, 
  "dc2_1" bigint, 
  "dc2_1_1_d" bigint, 
  "dc2_1_1_h" bigint, 
  "dc2_2" bigint, 
  "dc2_2_1_d" bigint, 
  "dc2_2_1_h" bigint, 
  "dc2_3" bigint, 
  "dc2_3_1_d" bigint, 
  "dc2_3_1_h" bigint, 
  "dc2_4" bigint, 
  "dc2_4_1_d" bigint, 
  "dc2_4_1_h" bigint, 
  "dc2_5" bigint, 
  "dc2_5_1_d" bigint, 
  "dc2_5_1_h" bigint, 
  "dc2_6" bigint, 
  "dc2_6_1_d" bigint, 
  "dc2_6_1_h" bigint, 
  "dc2_7" bigint, 
  "dc2_7_esp" text, 
  "dc2_7_1_d" bigint, 
  "dc2_7_1_h" bigint, 
  "dc3_1" bigint, 
  "dc3_2" bigint, 
  "dc3_3" bigint, 
  "dc3_4" bigint, 
  "dc3_5" bigint, 
  "dc3_6" bigint, 
  "dc3_6_esp" text, 
  "msi" bigint, 
  "msnombrei" text, 
  "msedadi" bigint, 
  "entreaind" bigint, 
  "noreaind" bigint, 
  "ut9_esp" text, 
  "tel_ms" text, 
  "correo_ms" text, 
  "dia" bigint, 
  "ut1" bigint, 
  "ut2" bigint, 
  "ut3" bigint, 
  "d1" bigint, 
  "d2" bigint, 
  "ut4" bigint, 
  "fin_1" bigint, 
  "fin_2" bigint, 
  "ut3_esp" text, 
  "diario_sin_errores" bigint, 
  "diario_comenzado" bigint, 
  "modulo_1" bigint
, primary key ("operativo", "vivienda", "hogar", "persona")
);
grant select, insert, update, delete, references on "personas" to ut_admin;
grant all on "personas" to ut_owner;



create table "visitas_sup" (
  "operativo" text, 
  "vivienda" text, 
  "visita" bigint, 
  "rol_sup" text, 
  "per_sup" bigint, 
  "usu_sup" text, 
  "fecha_sup" text, 
  "hora_sup" text, 
  "anotacion_sup" text
, primary key ("operativo", "vivienda", "visita")
);
grant select, insert, update, delete, references on "visitas_sup" to ut_admin;
grant all on "visitas_sup" to ut_owner;



create table "hogares_sup" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "resp_comp_sup" text, 
  "resp_comp_ed_sup" bigint, 
  "resp_indi_sup" text, 
  "resp_indi_ed_sup" bigint, 
  "entrea_hog" bigint, 
  "sp4" bigint, 
  "sp5_sup" text, 
  "spr2_sup" bigint, 
  "fecha_realiz_sup" date, 
  "nombres_componentes_sup" text, 
  "total_m_sup" bigint, 
  "respond_num" bigint, 
  "sorteo_sup" bigint, 
  "total_rango_sup" bigint, 
  "nro_miembro_sel_sup" bigint, 
  "nombre_miembro_sel_sup" text, 
  "spr3_sup" bigint, 
  "razon_hog_sup" bigint, 
  "razon_7_sup" bigint, 
  "razon_8_sup" bigint, 
  "razon_9_sup" bigint
, primary key ("operativo", "vivienda", "hogar")
);
grant select, insert, update, delete, references on "hogares_sup" to ut_admin;
grant all on "hogares_sup" to ut_owner;



create table "personas_sup" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "persona" bigint, 
  "nombre_sup" text, 
  "sexo_sup" bigint, 
  "p2b_sup" bigint, 
  "p2b_6_sup_esp" text, 
  "edad_sup" bigint, 
  "sp4_sup" bigint, 
  "spl0_sup" text, 
  "spp5" bigint
, primary key ("operativo", "vivienda", "hogar", "persona")
);
grant select, insert, update, delete, references on "personas_sup" to ut_admin;
grant all on "personas_sup" to ut_owner;


create table "actividades" (
  "operativo" text, 
  "vivienda" text, 
  "hogar" bigint, 
  "persona" bigint, 
  "renglon" bigint, 
  "codigo" bigint, 
  "desde" interval, 
  "hasta" interval, 
  "detalle" text
, primary key ("operativo", "vivienda", "hogar", "persona", "renglon")
);
grant select, insert, update, delete, references on "actividades" to ut_admin;
grant all on "actividades" to ut_owner;

alter table "viviendas" add constraint "operativo<>''" check ("operativo"<>'');
alter table "viviendas" alter column "operativo" set not null;
alter table "viviendas" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "viviendas" alter column "vivienda" set not null;
alter table "viviendas" add constraint "obs_re<>''" check ("obs_re"<>'');
alter table "viviendas" add constraint "razon3<>''" check ("razon3"<>'');
alter table "viviendas" add constraint "s1a1_obs_sup<>''" check ("s1a1_obs_sup"<>'');
alter table "viviendas" add constraint "datos_personal_sup<>''" check ("datos_personal_sup"<>'');
alter table "viviendas" add constraint "domicilio_sup<>''" check ("domicilio_sup"<>'');
alter table "viviendas" add constraint "razon3_sup<>''" check ("razon3_sup"<>'');
alter table "visitas" add constraint "operativo<>''" check ("operativo"<>'');
alter table "visitas" alter column "operativo" set not null;
alter table "visitas" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "visitas" alter column "vivienda" set not null;
alter table "visitas" alter column "visita" set not null;
alter table "visitas" add constraint "rol<>''" check ("rol"<>'');
alter table "visitas" add constraint "usu<>''" check ("usu"<>'');
alter table "visitas" add constraint "fecha<>''" check ("fecha"<>'');
alter table "visitas" add constraint "hora<>''" check ("hora"<>'');
alter table "visitas" add constraint "anotacion<>''" check ("anotacion"<>'');
alter table "hogares" add constraint "operativo<>''" check ("operativo"<>'');
alter table "hogares" alter column "operativo" set not null;
alter table "hogares" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "hogares" alter column "vivienda" set not null;
alter table "hogares" alter column "hogar" set not null;
alter table "hogares" add constraint "obs_s1<>''" check ("obs_s1"<>'');
alter table "hogares" add constraint "los_nombres<>''" check ("los_nombres"<>'');
alter table "hogares" add constraint "nombrer<>''" check ("nombrer"<>'');
alter table "hogares" add constraint "msnombre<>''" check ("msnombre"<>'');
alter table "hogares" add constraint "v2_esp<>''" check ("v2_esp"<>'');
alter table "hogares" add constraint "h2_esp<>''" check ("h2_esp"<>'');
alter table "hogares" add constraint "h20a_14_esp<>''" check ("h20a_14_esp"<>'');
alter table "hogares" add constraint "uh14_4_esp<>''" check ("uh14_4_esp"<>'');
alter table "hogares" add constraint "uh15_b_7_esp<>''" check ("uh15_b_7_esp"<>'');
alter table "hogares" add constraint "uh15_f_7_esp<>''" check ("uh15_f_7_esp"<>'');
alter table "hogares" add constraint "ut7_esp<>''" check ("ut7_esp"<>'');
alter table "hogares" add constraint "tel1<>''" check ("tel1"<>'');
alter table "hogares" add constraint "tel2<>''" check ("tel2"<>'');
alter table "personas" add constraint "operativo<>''" check ("operativo"<>'');
alter table "personas" alter column "operativo" set not null;
alter table "personas" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "personas" alter column "vivienda" set not null;
alter table "personas" alter column "hogar" set not null;
alter table "personas" alter column "persona" set not null;
alter table "personas" add constraint "nombre<>''" check ("nombre"<>'');
alter table "personas" add constraint "p2b_6_esp<>''" check ("p2b_6_esp"<>'');
alter table "personas" add constraint "l0<>''" check ("l0"<>'');
alter table "personas" add constraint "sn1b_1_esp<>''" check ("sn1b_1_esp"<>'');
alter table "personas" add constraint "sn1b_7_esp<>''" check ("sn1b_7_esp"<>'');
alter table "personas" add constraint "sn1b_2_esp<>''" check ("sn1b_2_esp"<>'');
alter table "personas" add constraint "sn1b_3_esp<>''" check ("sn1b_3_esp"<>'');
alter table "personas" add constraint "sn1b_4_esp<>''" check ("sn1b_4_esp"<>'');
alter table "personas" add constraint "m1_esp2<>''" check ("m1_esp2"<>'');
alter table "personas" add constraint "m1_esp3<>''" check ("m1_esp3"<>'');
alter table "personas" add constraint "m1_esp4<>''" check ("m1_esp4"<>'');
alter table "personas" add constraint "dc2_7_esp<>''" check ("dc2_7_esp"<>'');
alter table "personas" add constraint "dc3_6_esp<>''" check ("dc3_6_esp"<>'');
alter table "personas" add constraint "msnombrei<>''" check ("msnombrei"<>'');
alter table "personas" add constraint "ut9_esp<>''" check ("ut9_esp"<>'');
alter table "personas" add constraint "tel_ms<>''" check ("tel_ms"<>'');
alter table "personas" add constraint "correo_ms<>''" check ("correo_ms"<>'');
alter table "personas" add constraint "ut3_esp<>''" check ("ut3_esp"<>'');
alter table "visitas_sup" add constraint "operativo<>''" check ("operativo"<>'');
alter table "visitas_sup" alter column "operativo" set not null;
alter table "visitas_sup" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "visitas_sup" alter column "vivienda" set not null;
alter table "visitas_sup" alter column "visita" set not null;
alter table "visitas_sup" add constraint "rol_sup<>''" check ("rol_sup"<>'');
alter table "visitas_sup" add constraint "usu_sup<>''" check ("usu_sup"<>'');
alter table "visitas_sup" add constraint "fecha_sup<>''" check ("fecha_sup"<>'');
alter table "visitas_sup" add constraint "hora_sup<>''" check ("hora_sup"<>'');
alter table "visitas_sup" add constraint "anotacion_sup<>''" check ("anotacion_sup"<>'');
alter table "hogares_sup" add constraint "operativo<>''" check ("operativo"<>'');
alter table "hogares_sup" alter column "operativo" set not null;
alter table "hogares_sup" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "hogares_sup" alter column "vivienda" set not null;
alter table "hogares_sup" alter column "hogar" set not null;
alter table "hogares_sup" add constraint "resp_comp_sup<>''" check ("resp_comp_sup"<>'');
alter table "hogares_sup" add constraint "resp_indi_sup<>''" check ("resp_indi_sup"<>'');
alter table "hogares_sup" add constraint "sp5_sup<>''" check ("sp5_sup"<>'');
alter table "hogares_sup" add constraint "nombres_componentes_sup<>''" check ("nombres_componentes_sup"<>'');
alter table "hogares_sup" add constraint "nombre_miembro_sel_sup<>''" check ("nombre_miembro_sel_sup"<>'');
alter table "personas_sup" add constraint "operativo<>''" check ("operativo"<>'');
alter table "personas_sup" alter column "operativo" set not null;
alter table "personas_sup" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "personas_sup" alter column "vivienda" set not null;
alter table "personas_sup" alter column "hogar" set not null;
alter table "personas_sup" alter column "persona" set not null;
alter table "personas_sup" add constraint "nombre_sup<>''" check ("nombre_sup"<>'');
alter table "personas_sup" add constraint "p2b_6_sup_esp<>''" check ("p2b_6_sup_esp"<>'');
alter table "personas_sup" add constraint "spl0_sup<>''" check ("spl0_sup"<>'');
alter table "actividades" add constraint "operativo<>''" check ("operativo"<>'');
alter table "actividades" alter column "operativo" set not null;
alter table "actividades" add constraint "vivienda<>''" check ("vivienda"<>'');
alter table "actividades" alter column "vivienda" set not null;
alter table "actividades" alter column "hogar" set not null;
alter table "actividades" alter column "persona" set not null;
alter table "actividades" alter column "renglon" set not null;
alter table "actividades" add constraint "detalle<>''" check ("detalle"<>'');

alter table "visitas" add constraint "visitas viviendas REL" foreign key ("operativo", "vivienda") references "viviendas" ("operativo", "vivienda")  on delete cascade on update cascade;
alter table "hogares" add constraint "hogares viviendas REL" foreign key ("operativo", "vivienda") references "viviendas" ("operativo", "vivienda")  on delete cascade on update cascade;
alter table "personas" add constraint "personas hogares REL" foreign key ("operativo", "vivienda", "hogar") references "hogares" ("operativo", "vivienda", "hogar")  on delete cascade on update cascade;
alter table "visitas_sup" add constraint "visitas_sup viviendas REL" foreign key ("operativo", "vivienda") references "viviendas" ("operativo", "vivienda")  on delete cascade on update cascade;
alter table "hogares_sup" add constraint "hogares_sup viviendas REL" foreign key ("operativo", "vivienda") references "viviendas" ("operativo", "vivienda")  on delete cascade on update cascade;
alter table "personas_sup" add constraint "personas_sup hogares_sup REL" foreign key ("operativo", "vivienda", "hogar") references "hogares_sup" ("operativo", "vivienda", "hogar")  on delete cascade on update cascade;
alter table "actividades" add constraint "actividades personas REL" foreign key ("operativo", "vivienda", "hogar", "persona") references "personas" ("operativo", "vivienda", "hogar", "persona")  on delete cascade on update cascade;
alter table "actividades" add constraint "actividades actividades_codigos REL" foreign key ("codigo") references "actividades_codigos" ("codigo")  on update cascade;

create index "operativo,vivienda 4 visitas IDX" ON "visitas" ("operativo", "vivienda");
create index "operativo,vivienda 4 hogares IDX" ON "hogares" ("operativo", "vivienda");
create index "operativo,vivienda,hogar 4 personas IDX" ON "personas" ("operativo", "vivienda", "hogar");
create index "operativo,vivienda 4 visitas_sup IDX" ON "visitas_sup" ("operativo", "vivienda");
create index "operativo,vivienda 4 hogares_sup IDX" ON "hogares_sup" ("operativo", "vivienda");
create index "operativo,vivienda,hogar 4 personas_sup IDX" ON "personas_sup" ("operativo", "vivienda", "hogar");
create index "operativo,vivienda,hogar,persona 4 actividades IDX" ON "actividades" ("operativo", "vivienda", "hogar", "persona");
create index "codigo 4 actividades IDX" ON "actividades" ("codigo");

PERFORM enance_table('viviendas','operativo,vivienda');
PERFORM enance_table('visitas','operativo,vivienda,visita');
PERFORM enance_table('hogares','operativo,vivienda,hogar');
PERFORM enance_table('personas','operativo,vivienda,hogar,persona');
PERFORM enance_table('visitas_sup','operativo,vivienda,visita');
PERFORM enance_table('hogares_sup','operativo,vivienda,hogar');
PERFORM enance_table('personas_sup','operativo,vivienda,hogar,persona');
PERFORM enance_table('actividades','operativo,vivienda,hogar,persona,renglon');

