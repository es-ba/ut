set search_path=base;
set role ut2023_owner;
insert into roles(rol,superuser,nombre) values ('coor_proc',false,'Coordinador de Procesamiento');
insert into roles_subordinados values
  ('coor_proc','coor_campo'),
  ('coor_proc','procesamiento');
insert into roles_permisos values
  ('coor_proc','campo','administrar',true),
  ('coor_proc','campo','editar',true),
  ('coor_proc','campo','ver',true),
  ('coor_proc','casilleros_texto','editar',false),
  ('coor_proc','configurar','editar',true),
  ('coor_proc','configurar','ver',true),
  ('coor_proc','consistencias','editar',true),
  ('coor_proc','encuestas','ingresar',true),
  ('coor_proc','encuestas','justificar',true),
  ('coor_proc','encuestas','procesar',true);

