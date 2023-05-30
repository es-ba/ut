set search_path=base;
--set role owner

update casilleros 
  set expresion_habilitar='entrea=2 or contacto=2'
  where operativo='UT_2023' and casillero='razon' and var_name='razon1';
