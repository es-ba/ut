set search_path=base;

update casilleros 
  set especial='{"noScroll":true}'
  where operativo='UT_2023' and padre = 'D1' and casillero = '1';
  
update casilleros 
  set especial='{"noScroll":true}'
  where operativo='UT_2023' and padre = 'D2' and casillero = '1';
