set search_path=base;

alter table estados add column permite_editar_encuesta boolean not null default true;