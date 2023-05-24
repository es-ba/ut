"use strict";
                
import {TableDefinition, TableContext} from "./types-ut";
export function hogares(context:TableContext):TableDefinition {
    var esEditable=context.user.rol==='admin';
    return {
    "name": "hogares",
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
            "name": "obs_s1",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "entrea",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "f_realiz_o",
            "typeName": "date",
            "nullable": true
        },
        {
            "name": "los_nombres",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "total_m",
            "typeName": "bigint",
            "nullable": true
        },
        { //respond siempre es 1 tiene sentido tener esta variable?
            "name": "respond",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "nombrer",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sorteo",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "tp",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "cr_num_miembro",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "msnombre",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "v2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "v2_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "h2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h2_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "h3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_20",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_21",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_12",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_11",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_14",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "h20a_14_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "it1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "it2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh12",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh13_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh13_min",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh14_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh14_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh14_3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh14_4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh14_4_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "uh15",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_6",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_7",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_b_7_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "uh15_c",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_6",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_e_7",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh15_f_7_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "uh17",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh17_a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "uh17_b",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut7_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "tel1",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "tel2",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "razon1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon2_7",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon2_8",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "razon2_9",
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
            "table": "personas",
            "fields": [
                "operativo",
                "vivienda",
                "hogar"
            ],
            "abr": "p"
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