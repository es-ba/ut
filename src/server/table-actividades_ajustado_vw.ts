"use strict";
                
import {TableDefinition, TableContext} from "./types-ut";
export function actividades_ajustado_vw(context:TableContext):TableDefinition {
    return {
    "name": "actividades_ajustado_vw",
    editable: false,
    "fields": [
        {
            "name": "operativo",
            "typeName": "text",
            "nullable": false
        },
        {
            "name": "vivienda",
            "typeName": "text",
            "nullable": false
        },
        {
            "name": "hogar",
            "typeName": "bigint",
            "nullable": false
        },
        {
            "name": "persona",
            "typeName": "bigint",
            "nullable": false
        },
        {
            "name": "renglon",
            "typeName": "bigint",
            "nullable": false
        },
        {  
            "name": "codigoa", 
            "typeName": "bigint",
            "nullable": true
        },
        /*
        {
            "name": "detalle",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "desde",
            "typeName": "interval",
            "nullable": true
        },
        {
            "name": "hasta",
            "typeName": "interval",
            "nullable": true
        },
        */
        {
            "name": "desde_min",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "hasta_min",
            "typeName": "bigint",
            "nullable": true
        },
        /*
        {
            "name": "t_con_simu_hm",
            "typeName": "interval",
            "nullable": true
        },
        {
            "name": "t_con_simu_min",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ajustado_min",
            "typeName": "decimal",
            "nullable": true
        },        
        {
            "name": "ajustado",
            "typeName": "interval",
            "nullable": true
        },        
        {
            "name": "simultaneidad_promedio_del_individuo",
            "typeName": "decimal",
            "nullable": true
        },
        {
            "name": "simultaneidad_maxima",
            "typeName": "bigint",
            "nullable": true
        },
        */
        {
            "name": "t_sin_simu_hm",
            "typeName": "interval",
            "nullable": true
        },
        {
            "name": "t_sin_simu_min",
            "typeName": "bigint",
            "nullable": true
        },
    ],
    "sql": {
        isTable:false,
        from :  `(select operativo, vivienda, hogar, persona,renglon, desde, hasta, desde_min, hasta_min, codigo codigoa, detalle, ajustado_min, ajustado::interval ajustado, simultaneidad_promedio_del_individuo
                --,t_con_simu_hm, t_con_simu_min, simultaneidad_maxima
            , t_sin_simu_min, t_sin_simu_hm::interval t_sin_simu_hm
            from actividades_ajustado_vw)`,        
        skipEnance: true,
    },
    "primaryKey": [
        "operativo",
        "vivienda",
        "hogar",
        "persona",
        "renglon"
    ],
    "detailTables": [],
    
    "softForeignKeys": [
        {
            "references": "actividades",
            "fields": [
                "operativo",
                "vivienda",
                "hogar",
                "persona",
                "renglon"
            ],
            //"onDelete":'cascade'
        },
        {
            "references": "actividades_codigos",
            fields:[
                {source:'codigoa', target:'codigo'}
            ]    
        }

    ]
};
}