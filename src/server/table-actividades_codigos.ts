"use strict";
//https://www.estadisticaciudad.gob.ar/eyc/wp-content/uploads/2017/10/Uso-del-Tiempo-2016.pdf

import {TableDefinition, TableContext} from "./types-ut";

export function actividades_codigos(context:TableContext):TableDefinition {
    var be=context.be;
    var puedeEditar = context.forDump || context.puede?.campo?.administrar||context.user.rol==='recepcionista';
    return {
        name:'actividades_codigos',
        elementName:'actividad_codigo',
        editable:puedeEditar,
        fields:[
            {name:'codigo'          , typeName: 'integer'  , editable: true, nullable: false },
            {name:'nombre_variable' , typeName: 'text'     , editable: true, /*nullable: false */},
            {name:'texto'           , typeName: 'text'     , editable: true, nullable: false },
            {name:'abr'             , typeName: 'text'     , editable: true, nullable: false , label:'abr (para Tarjeta)'},
            {name:'detalle'         , typeName: 'text'     , editable: true, nullable: false },
            {name:'imagen'          , typeName: 'text'     , editable: true,/* nullable: false*/ },
            {name:'exclusividad'    , typeName: 'boolean'  , editable: true, nullable: false },
            {name:'grupo'           , typeName: 'text'     , editable: true,/* nullable: false*/ },
            {name:'obligatoriedad'  , typeName: 'boolean'  , editable: true, nullable: false },
            {name:'opcion_d12'      , typeName: 'boolean'  , editable: true, nullable: false },
            {name:'opcion_d13'      , typeName: 'boolean'  , editable: true, nullable: false },
            {name:'opcion_d22'      , typeName: 'boolean'  , editable: true, nullable: false },
            {name:'opcion_d23'      , typeName: 'boolean'  , editable: true, nullable: false },
            {name:'color'           , typeName: 'text'     , editable: true, nullable: false },
            {name:'icono'           , typeName: 'text'     , editable: true                  },
            {name:'rescatable'      , typeName: 'boolean'  , editable: true, nullable: false },
        ],
        primaryKey:['codigo'],
        constraints:[
            {consName:'grupos considerados',constraintType:'check', expr:"grupo in ('D','F','M')"},
        ],
        
    };
}

