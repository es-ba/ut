set search_path= base, comun;
--cambiar owner y admin
set role ut2023_owner;
CREATE OR REPLACE VIEW actividades_cotas_vw
    AS
    SELECT y.operativo, y.vivienda,
        y.hogar,
        y.persona,
        y.cota_min,
        y.cota,
        y.cota_min_sup,
        y.cota_sup
        FROM ( SELECT x.operativo, x.vivienda,
            x.hogar,
            x.persona,
            x.cota_min,
            x.cota,
            lead(x.cota_min) OVER (PARTITION BY x.vivienda, x.hogar, x.persona ORDER BY x.cota_min) AS cota_min_sup,
            lead(x.cota) OVER (PARTITION BY x.vivienda, x.hogar, x.persona ORDER BY x.cota) AS cota_sup
            FROM ( 
                SELECT d.operativo, d.vivienda, d.hogar, d.persona, dc.desde_min AS cota_min, d.desde AS cota
                    FROM actividades d join ut_2023_actividades_calculada dc using(operativo,vivienda,hogar,persona,renglon) 
                    UNION
                    SELECT h.operativo, h.vivienda, h.hogar, h.persona, hc.hasta_min AS cota_min, h.hasta AS cota
                        FROM actividades h join ut_2023_actividades_calculada hc using(operativo,vivienda,hogar,persona,renglon)
            ) x
            GROUP BY x.operativo, x.vivienda, x.hogar, x.persona, x.cota_min, x.cota
        ) y
        WHERE y.cota_min_sup IS NOT NULL
        ORDER BY y.operativo, y.vivienda, y.hogar, y.persona, y.cota_min, y.cota;


CREATE OR REPLACE VIEW simultaneidades_vw
    AS
    SELECT c.operativo, c.vivienda,
        c.hogar,
        c.persona,
        c.cota_min,
        c.cota,
        c.cota_sup,
        c.cota_min_sup,
        count(*) AS cant_activ,
        array_agg(a.codigo) AS codigos_ar,
        string_agg(a.codigo::text, ','::text) AS codigos_st
        FROM actividades_cotas_vw c
            JOIN actividades a USING (operativo,vivienda,hogar,persona)
            JOIN ut_2023_actividades_calculada ac USING (operativo,vivienda,hogar,persona,renglon)
        WHERE ac.desde_min <= c.cota_min AND ac.hasta_min >= c.cota_min_sup
        GROUP BY c.operativo, c.vivienda, c.hogar, c.persona, c.cota_min, c.cota, c.cota_sup, c.cota_min_sup
        ORDER BY c.operativo, c.vivienda, c.hogar, c.persona, c.cota_min, c.cota;


CREATE OR REPLACE VIEW actividades_ajustado_vw
    AS
    SELECT a.operativo, a.vivienda,
        a.hogar,
        a.persona,
        ac.desde_min,
        a.desde,
        ac.hasta_min,
        a.hasta,
        a.codigo,
        a.detalle,
        ac.tiempo_epi AS t_con_simu_hm,
        ac.cant_minutos_epi AS t_con_simu_min,
        sum(GREATEST(0, LEAST(s.cota_min_sup, ac.hasta_min) - GREATEST(s.cota_min, ac.desde_min))::numeric * 1.0 / s.cant_activ::numeric) AS ajustado_min,
        to_char((sum(GREATEST(0, LEAST(s.cota_min_sup, ac.hasta_min) - GREATEST(s.cota_min, ac.desde_min))::numeric * 1.0 / s.cant_activ::numeric) || ' minutes '::text)::interval, 'HH24:MI:SS'::text) AS ajustado,
        avg(s.cant_activ) AS simultaneidad_promedio_del_individuo,
        max(s.cant_activ) AS simultaneidad_maxima
        sum(GREATEST(0, LEAST(s.cota_min_sup, ac.hasta_min) - GREATEST(s.cota_min, ac.desde_min))::numeric * 1.0 / s.cant_activ::numeric)::integer AS t_sin_simu_min,
        to_char((sum(GREATEST(0, LEAST(s.cota_min_sup, ac.hasta_min) - GREATEST(s.cota_min, ac.desde_min))::numeric * 1.0 / s.cant_activ::numeric) || ' minutes '::text)::interval, 'HH24:MI'::text) AS t_sin_simu_hm
        FROM simultaneidades_vw s
            JOIN actividades a USING(operativo,vivienda,hogar,persona) 
            JOIN ut_2023_actividades_calculada ac USING(operativo,vivienda,hogar,persona,renglon) 
        GROUP BY a.operativo, a.vivienda, a.hogar, a.persona, ac.desde_min, a.desde, ac.hasta_min, a.hasta, a.codigo, a.detalle, ac.tiempo_epi, ac.cant_minutos_epi
        ORDER BY a.operativo, a.vivienda, a.hogar, a.persona, a.desde, a.hasta DESC, a.codigo;


grant select on "actividades_cotas_vw"    to ut2023_admin;
grant select on "simultaneidades_vw"      to ut2023_admin;
grant select on "actividades_ajustado_vw" to ut2023_admin;


