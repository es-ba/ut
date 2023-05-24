"use strict";
                
import {TableDefinition, TableContext} from "./types-ut";
export function personas(context:TableContext):TableDefinition {
    var esEditable=context.user.rol==='admin';
    return {
    "name": "personas",
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
            "name": "persona",
            "typeName": "bigint",
            "nullable": false
        },        
        {
            "name": "nombre",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sexo",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "p2b",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "p2b_6_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "edad",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "p4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "lp",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "l0",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "p5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "p5b",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "p6a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "p6b",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t1a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t3a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t9a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t29b",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t44a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t46a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "t51a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sn1b_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sn1b_1_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sn1b_7",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sn1b_7_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sn1b_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sn1b_2_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sn1b_3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sn1b_3_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sn1b_4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "sn1b_4_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "sn1b_5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "m1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "m1_esp2",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "m1_esp3",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "m1_esp4",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "e2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "e6a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "e2t_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "e2t_min",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "e12a",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "e13",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_1_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_1_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_2_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_2_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_3_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_3_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_4_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_4_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_5_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_5_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_6",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_6_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_6_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_7",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_7_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "dc2_7_1_d",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc2_7_1_h",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_5",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_6",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "dc3_6_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "msi",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "msnombrei",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "msedadi",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "entreaind",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "noreaind",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut9_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "tel_ms",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "correo_ms",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "dia",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut3",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "d1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "d2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut4",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "fin_1",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "fin_2",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "ut3_esp",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "diario_sin_errores",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "diario_comenzado",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "modulo_1",
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
        "hogar",
        "persona"
    ],
    "detailTables": [
        {
            "table": "actividades",
            "fields": [
                "operativo",
                "vivienda",
                "hogar",
                "persona"
            ],
            "abr": "a"
        }
    ],
    "foreignKeys": [
        {
            "references": "hogares",
            "fields": [
                "operativo",
                "vivienda",
                "hogar"
            ],
            "onDelete": 'cascade'
        }
    ]
};
}