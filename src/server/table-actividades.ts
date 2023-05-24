"use strict";
                
import {TableDefinition, TableContext} from "./types-ut";
export function actividades(context:TableContext):TableDefinition {
    var esEditable=context.user.rol==='admin';
    return {
    "name": "actividades",
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
        {  // ó actividad? en json vendrá codigo. Lo cambiamos? 
            "name": "codigo", 
            "typeName": "bigint",
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
        {
            "name": "detalle",
            "typeName": "text",
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
        "persona",
        "codigo"
    ],
    "detailTables": [],
    "foreignKeys": [
        {
            "references": "personas",
            "fields": [
                "operativo",
                "vivienda",
                "hogar",
                "persona"
            ],
            "onDelete":'cascade'
        },
        {
            "references": "actividades_codigos",
            fields:[
                'codigo'
            ]    
        }

    ]
};
}