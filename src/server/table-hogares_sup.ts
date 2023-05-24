"use strict";
                
import {TableDefinition, TableContext} from "./types-ut";
export function hogares_sup(context:TableContext):TableDefinition {
    var esEditable=context.user.rol==='admin';
    return {
    "name": "hogares_sup",
    editable: esEditable,
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
            "name": "resp_comp_sup",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "resp_comp_ed_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "resp_indi_sup",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "resp_indi_ed_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "entrea_hog",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sp4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sp5_sup",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "spr2_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "fecha_realiz_sup",
            "typeName": "date",
            "nullable": true
        },
        {
            "name": "nombres_componentes_sup",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "total_m_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "respond_num",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sorteo_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "total_rango_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "nro_miembro_sel_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "nombre_miembro_sel_sup",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "spr3_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon_hog_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon_7_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon_8_sup",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon_9_sup",
            "typeName": "bigint",
            "nullable": true
        }
    ],
    "sql": {
        "isReferable": true
    },
    "primaryKey": [
        "operativo",
        "vivienda",
        "hogar"
    ],
    "detailTables": [
        {
            "table": "personas_sup",
            "fields": [
                "operativo",
                "vivienda",
                "hogar"
            ],
            "abr": "ps"
        }
    ],
    "foreignKeys": [
        {
            "references": "viviendas",
            "fields": [
                "operativo",
                "vivienda"
            ],
            "onDelete": 'cascade'
        }
    ]
};
}