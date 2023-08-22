set search_path = base;

update tareas_tem tt
    set estado = 'D', cargado_dm=null
	from tem t 
	where t.operativo = 'UT_2023' and tt.operativo = t.operativo and t.enc = tt.enc and t.area = 228 and tt.estado = 'CD';