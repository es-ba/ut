set search_path=base;
/*graciela*/
alter table tem add column result_sup integer;
alter table tem add constraint vresult_sup_ck check (result_sup between 1 and 9 or result_sup in (11,12,21,22 ) or result_sup between 60 and 68);
/*fin graciela*/

alter table estados add column visible_en_ingreso boolean not null default false;
alter table acciones add column ingresa boolean not null default false;

insert into "estados" ("operativo", "estado", "desc_estado", "orden_estado", "permite_asignar", "permite_editar_encuesta", "estado_al_asignar", "visible_en_recepcion", "visible_en_ingreso") values ('UT_2023', 'I', 'Ingresando', '35', 'false', 'false', null, 'true', 'true');

update estados set visible_en_ingreso = true where operativo = 'UT_2023' and estado in ('A', 'AC', 'I', 'D','P');

insert into "acciones" ("operativo", "eaccion", "abr_eaccion", "desactiva_boton", "path_icono_svg", "desc_eaccion", "confirma", "recepciona", "ingresa") values
('UT_2023', 'abrir', 'ingr', 'false', 'M43.62 22.25l1.21 1.21 0.46 -0.47 2.07 2.07 -0.47 0.47 -3.27 -3.28c-2.11,2.1 -10.64,10.63 -12.75,12.74 -0.18,0.15 -0.3,0.31 -0.33,0.49 -0.45,1.33 -0.8,3.06 -1.16,4.45 -0.11,0.45 0.16,0.92 0.62,1.04 0.14,0.03 0.29,0.03 0.42,0l4.44 -1.16 -1.87 -1.27 -1.59 0.41 0.42 -1.58 1.17 1.17 1.87 1.27c0.15,-0.04 0.28,-0.11 0.39,-0.22l3.65 -3.65 0 8.84 -27.8 0 0 -38.03 7.5 0c0.01,0.76 0.63,1.37 1.39,1.37l10.02 0c0.76,0 1.38,-0.61 1.39,-1.37l7.5 0 0 20.21 2.6 -2.6 0 -17.79c0,-0.66 -0.27,-1.26 -0.71,-1.7 -0.44,-0.44 -1.04,-0.71 -1.7,-0.71l-7.69 0 0 -0.15c0,-0.77 -0.62,-1.39 -1.39,-1.39l-10.02 0c-0.77,0 -1.39,0.62 -1.39,1.39l0 0.15 -7.69 0c-0.66,0 -1.26,0.27 -1.7,0.71 -0.44,0.44 -0.71,1.04 -0.71,1.7l0 38.39c0,0.67 0.27,1.27 0.71,1.71 0.43,0.44 1.04,0.71 1.7,0.71l28.18 0c0.66,0 1.27,-0.27 1.7,-0.72 0.44,-0.43 0.71,-1.03 0.71,-1.7l0 -11.62 7.15 -7.15c0.29,-0.33 0.43,-0.73 0.43,-1.13 0,-0.42 -0.16,-0.86 -0.49,-1.19l-2.11 -2.11c-0.33,-0.32 -0.76,-0.49 -1.19,-0.49 -0.43,0 -0.86,0.17 -1.19,0.49 -0.12,0.12 -0.36,0.37 -0.48,0.49zm-8.97 15.53l-2.07 -2.07 11.03 -11.04 2.07 2.07 -11.03 11.04z', 'abrir encuesta para ingreso no presencial', 'false', 'false','true'),
('UT_2023', 'no_ingresar', 'no_ingr', 'false', 'M44.83 23.46l0.46 -0.47 2.07 2.07 -0.47 0.47 -2.06 -2.07zm-1.21 -1.21l-2.12 2.11 0 -17.79c0,-0.66 -0.27,-1.26 -0.71,-1.7 -0.44,-0.44 -1.04,-0.71 -1.7,-0.71l-7.69 0 0 -0.15c0,-0.77 -0.62,-1.39 -1.39,-1.39l-10.02 0c-0.77,0 -1.39,0.62 -1.39,1.39l0 0.15 -7.69 0c-0.66,0 -1.26,0.27 -1.7,0.71l-0.08 0.08 1.97 1.97 0 -0.17 7.5 0c0.01,0.76 0.63,1.37 1.39,1.37l10.02 0c0.76,0 1.38,-0.61 1.39,-1.37l7.5 0 0 20.21 -3.88 3.88 1.21 1.21 7.38 -7.38 2.07 2.07 -7.38 7.38 3.2 3.2 0 -3.98 7.15 -7.15c0.29,-0.33 0.43,-0.73 0.43,-1.13 0,-0.42 -0.16,-0.86 -0.49,-1.19l-2.11 -2.11c-0.33,-0.32 -0.76,-0.49 -1.19,-0.49 -0.43,0 -0.86,0.17 -1.19,0.49 -0.12,0.12 -0.36,0.37 -0.48,0.49zm-39.78 -14.23c-0.57,-0.58 -0.57,-1.51 0,-2.09 0.58,-0.57 1.52,-0.57 2.09,0 12.68,12.68 25.35,25.35 38.02,38.02 0.58,0.58 0.58,1.51 0,2.09 -0.58,0.57 -1.51,0.57 -2.09,0l-0.44 -0.45c-0.12,0.41 -0.34,0.78 -0.63,1.07 -0.43,0.45 -1.04,0.72 -1.7,0.72l-28.18 0c-0.66,0 -1.27,-0.27 -1.7,-0.71 -0.44,-0.44 -0.71,-1.04 -0.71,-1.71l0 -32.28 -4.66 -4.66zm35.06 35.06l-3.57 -3.57 -0.08 0.08c-0.11,0.11 -0.24,0.18 -0.39,0.22l-4.44 1.16c-0.13,0.03 -0.28,0.03 -0.42,0 -0.46,-0.12 -0.73,-0.59 -0.62,-1.04l1.32 -5.05c-19.24,-19.24 -5.32,-5.33 -19.6,-19.61l0 29.51 27.8 0 0 -1.7zm-5.91 -4.54l-1.17 -1.17 -0.42 1.58 1.59 -0.41z', 'no ingresar encuesta', 'false', 'false','false'),
('UT_2023', 'finalizar', 'fin', 'false', 'M19.03 43.08c-4.68,-8.63 -9.49,-15.22 -14.83,-18.72 2.65,-0.8 5.15,-1.48 7.8,-2.29 3.25,1.35 5.34,3.12 7.03,5.02 4.42,-7.47 10.45,-14.23 18.44,-20.13 2.78,-0.01 5.56,-0.02 8.34,-0.03 -10.61,11.31 -19.74,23.27 -26.78,36.15z', 'finalizar ingreso', 'false', 'false','true'),
('UT_2023', 'no_finalizar', 'no_fin', 'false', 'M19.03 43.07c-4.68,-8.62 -9.49,-15.21 -14.83,-18.71 2.64,-0.81 5.15,-1.48 7.8,-2.29 3.25,1.35 5.34,3.12 7.03,5.02 0.73,-1.23 1.51,-2.45 2.33,-3.65l-10.57 -10.56c-0.58,-0.58 -0.58,-1.51 0,-2.09 0.58,-0.58 1.51,-0.58 2.09,0 8.78,8.78 17.55,17.55 26.33,26.33 0.58,0.58 0.58,1.51 0,2.09 -0.58,0.58 -1.51,0.58 -2.09,0l-9.66 -9.66c-3.11,4.47 -5.97,9.03 -8.43,13.52zm5.92 -24.38c3.5,-4.21 7.64,-8.13 12.52,-11.73 2.78,-0.02 5.56,-0.02 8.34,-0.04 -5.04,5.37 -10.14,11.43 -14.86,17.77l-6 -6z', 'no finalizar ingreso', 'true', 'false','true');

insert into "estados_acciones" ("operativo", "estado", "eaccion", "condicion", "estado_destino", "eaccion_direccion", "nombre_procedure", "nombre_wscreen") values
('UT_2023', 'A', 'abrir', 'habilitada and estado = ''A''', 'I', 'avance', null, 'abrir_encuesta'),
('UT_2023', 'AC', 'abrir', 'habilitada and estado = ''AC''', 'I', 'avance', null, 'abrir_encuesta'),
('UT_2023', 'I', 'finalizar', 'habilitada and estado = ''I''', 'D', 'avance', null, null),
('UT_2023', 'D', 'no_finalizar', 'habilitada and te.result_sup is null', 'I', 'retroceso', null, null),
('UT_2023', 'P', 'no_finalizar', 'habilitada and te.result_sup is null', 'I', 'retroceso', null, null),
('UT_2023', 'I', 'abrir', 'habilitada and estado = ''I''', 'I', 'avance', null, 'abrir_encuesta'),
('UT_2023', 'I', 'no_ingresar', 'habilitada and estado = ''I''', 'A', 'retroceso', null, null);
