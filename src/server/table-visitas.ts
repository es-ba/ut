"use strict";
                
import {TableDefinition, TableContext} from "./types-ut";
export function visitas(context:TableContext):TableDefinition {
    var esEditable=context.user.rol==='admin';
    return {
    "name": "visitas",
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
            "name": "visita",
            "typeName": "bigint",
            "nullable": false
        },         
        {
            "name": "rol",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "per",
            "typeName": "bigint",
            "nullable": true
        },
        {
            "name": "usu",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "fecha",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "hora",
            "typeName": "text",
            "nullable": true
        },
        {
            "name": "anotacion",
            "typeName": "text",
            "nullable": true
        }
    ],
    "sql": {
        "isReferable": true,
        skipEnance: true,
    },
    "primaryKey": [
        "operativo",
        "vivienda",
        "visita"
    ],
    "detailTables": [],
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