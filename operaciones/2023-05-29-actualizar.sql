
set search_path=base;

alter table estados_acciones add column nombre_wscreen text;

update estados_acciones set nombre_wscreen = 'abrir_encuesta' where eaccion = 'analizar';