set search_path = base;


--vuelve una encuesta a recu desde proc

--12407
update tem 
  set tarea_actual = 'recu', tarea_proxima = null
  where operativo = 'UT_2023' and enc = '12407' and tarea_actual = 'proc';
  
update tareas_tem 
  set estado = '0D' 
  where operativo = 'UT_2023' and enc = '12407' and tarea in ('proc','recu');
  
update tareas_tem 
  set asignado = null
  where operativo = 'UT_2023' and enc = '12407' and tarea  = 'recu';
  
update tareas_tem 
  set recepcionista = null
  where operativo = 'UT_2023' and enc = '12407' and tarea  = 'recu';
--fin 12407
  

--64003
update tem 
  set tarea_actual = 'recu', tarea_proxima = null
  where operativo = 'UT_2023' and enc = '64003' and tarea_actual = 'proc';
  
update tareas_tem 
  set estado = '0D' 
  where operativo = 'UT_2023' and enc = '64003' and tarea in ('proc','recu');
  
update tareas_tem 
  set asignado = null
  where operativo = 'UT_2023' and enc = '64003' and tarea  = 'recu';
  
update tareas_tem 
  set recepcionista = null
  where operativo = 'UT_2023' and enc = '64003' and tarea  = 'recu';
--fin 64003

--64013
update tem 
  set tarea_actual = 'recu', tarea_proxima = null
  where operativo = 'UT_2023' and enc = '64013' and tarea_actual = 'proc';
  
update tareas_tem 
  set estado = '0D' 
  where operativo = 'UT_2023' and enc = '64013' and tarea in ('proc','recu');
  
update tareas_tem 
  set asignado = null
  where operativo = 'UT_2023' and enc = '64013' and tarea  = 'recu';
  
update tareas_tem 
  set recepcionista = null
  where operativo = 'UT_2023' and enc = '64013' and tarea  = 'recu';
--fin 64013