"use strict";

import { ProcedureDef, ProcedureContext, CoreFunctionParameters } from "./types-ut";
import {json, jsono} from "pg-promise-strict";
import { setHdrQuery, getOperativoActual } from "dmencu/dist/server/server/procedures-dmencu"

//import { hogares } from "./table-hogares";

setHdrQuery((quotedCondViv:string)=>{
    return `
    with viviendas as 
        (select t.enc, t.json_encuesta as respuestas, t.resumen_estado as "resumenEstado", 
            jsonb_build_object(
                'dominio'       , dominio       ,
                'nomcalle'      , nomcalle      ,
                'sector'        , sector        ,
                'edificio'      , edificio      ,
                'entrada'       , entrada       ,
                'nrocatastral'  , nrocatastral  ,
                'piso'          , piso          ,
                'departamento'  , departamento  ,
                'habitacion'    , habitacion    ,
                'casa'          , casa          ,
                'prioridad'     , reserva+1     ,
                'observaciones' , tt.carga_observaciones ,
                'cita'          , cita ,
                'carga'         , t.area
            ) as tem, t.area,
            jsonb_build_object(
                'tarea', tt.tarea,
                'fecha_asignacion', fecha_asignacion,
                'asignado', asignado,
                'main_form', main_form
            ) as tarea,
            min(fecha_asignacion) as fecha_asignacion
            from tem t left join tareas_tem tt on (t.operativo = tt.operativo and t.enc = tt.enc and t.tarea_actual = tt.tarea)
                       left join tareas ta on t.tarea_actual = ta.tarea
            where ${quotedCondViv}
            group by t.operativo, t.enc, t.json_encuesta, t.resumen_estado, dominio, nomcalle,sector,edificio, entrada, nrocatastral, piso,departamento,habitacion,casa,reserva,tt.carga_observaciones, cita, t.area, tt.tarea, fecha_asignacion, asignado, main_form
        )
        select jsonb_build_object(
                'viviendas', ${jsono(
                    `select enc, respuestas, jsonb_build_object('resumenEstado',"resumenEstado") as otras from viviendas`,
                    'enc',
                    `otras || coalesce(respuestas,'{}'::jsonb)`
                )}
            ) as respuestas,
            ${json(`
                select area as carga, observaciones_hdr as observaciones, min(fecha_asignacion) as fecha
                    from viviendas inner join areas using (area) 
                    group by area, observaciones_hdr`, 
                'fecha')} as cargas,
            ${jsono(
                `select enc, jsonb_build_object('tem', tem, 'tarea', tarea ) as otras from viviendas`,
                    'enc',
                    `otras ||'{}'::jsonb`
                )}
            as "informacionHdr"
`
    
})

export const procedures : ProcedureDef[] = [
    {
        action:'limpiar_individual',
        parameters:[
            {name:'enc'            ,references:'tem'       , typeName:'text'    },
            {name:'hogar'          ,references:'personas'  , typeName:'integer' },
            {name:'persona'        ,references:'personas'  , typeName:'integer', label:'persona cuyos datos de I1 hay que limpiar' },
            {name:'nombre_persona'        , typeName:'text'   , label:'nombre de la persona cuyos datos del I1 hay que limpiar' },
            {name:'confirma'              , typeName:'boolean', defaultValue:false, label:'Confirma borrado de los datos del I1 de la persona? ' },
        ],
        roles:['coor_proc','procesamiento','admin'],
        definedIn:'ut',
        progress:true,
        coreFunction:async function(context:ProcedureContext, params: CoreFunctionParameters){
            if (!params.confirma){
                throw new Error('No confirmó la limpieza')
            }

            const OPERATIVO = await getOperativoActual(context);
            // validar que no sea el seleccionado
            const seleccionado = (await context.client.query(`
                SELECT cr_num_miembro
                  FROM hogares h 
                  WHERE operativo=$1 and vivienda=$2 and hogar=$3 
            `,[OPERATIVO, params.enc, params.hogar]).fetchUniqueValue()).value;
            if (params.persona == seleccionado) {
                throw new Error('Error, está queriendo limpiar al seleccionado!');
            }
            //validar nombre 
            const nombre_per=(await context.client.query(`
                select nombre from personas where operativo=$1 and vivienda=$2 and hogar=$3 and persona=$4
                `,[OPERATIVO, params.enc, params.hogar, params.persona]).fetchUniqueValue()).value;
             if ( !nombre_per)  {
                    throw new Error('Error, la persona a limpiar no existe o su nombre no esta ingresado!');
            }            
            if (params.nombre_persona !== nombre_per) {
                    throw new Error('Error, no coincide el nombre de la persona a limpiar!');
            }
            //revisar/agregar borrado del diario
            const listVarI1=(await context.client.query(`
                with recursive subcasilleros(operativo, id_casillero) as (
                  select operativo, id_casillero, 0::bigint as depth
                       FROM casilleros where operativo=$1 and
                         id_casillero in (select id_casillero from casilleros where operativo= $2 AND unidad_analisis='personas' and tipoc='F' and nombre!~*'personas')
                  union all
                    select c.operativo, c.id_Casillero, s.depth+1
                        from subcasilleros s inner join casilleros c 
                            on s.operativo = c.operativo and s.id_casillero = c.padre
                ), x AS (select  s.*, cr.*
                    from subcasilleros s, lateral casilleros_recursivo(operativo, id_casillero) cr
                    where s.operativo=$3
                    order by s.depth desc, orden_total desc
                )
                select string_agg(quote_literal(var_name), '-' order by orden_total) jsonKeyBorrado, string_agg (concat(var_name,'=null'),', ') setUpd   from casilleros c , x
                where x.operativo=c.operativo and x.id_casillero=c.id_casillero
                    and c.var_name is not null
                `,[OPERATIVO,OPERATIVO,OPERATIVO]).fetchUniqueRow()).row;

            var pos_hog:number=params.hogar-1;
            var pos_per:number=params.persona-1;
            // AGREGO EN DURO LA UA HIJA DE PERSONAS
           var keyActividades='actividades';
            var strUpdTem=`
              update tem set json_encuesta=jsonb_set(json_encuesta,'{hogares,${pos_hog},personas,${pos_per}}',
                (json_encuesta#>('{hogares,${pos_hog},personas,${pos_per}}')) - ${listVarI1.jsonkeyborrado}-'${keyActividades}' )
                where operativo=$1 and enc=$2
            `;
            await context.client.query(strUpdTem
              , [ OPERATIVO, params.enc]
            ).execute();

            await context.client.query('delete from actividades where operativo=$1 and vivienda=$2 and hogar=$3 and persona=$4'
                , [ OPERATIVO, params.enc, params.hogar, params.persona]
              ).execute();
  
            var strUpdPer=`
              update personas 
                set ${listVarI1.setupd}
                where operativo=$1 and vivienda=$2 and hogar=$3 and persona=$4
            `;
            await context.client.query(strUpdPer
              , [ OPERATIVO, params.enc, params.hogar, params.persona]
              ).execute();

            /*
            UPDATE tem set json_encuesta=jsonb_set(json_encuesta,'{hogares,vhogar-1,personas,vpersona-1}',
            (json_encuesta#>('{hogares,vhogar-1,personas,vpersona-1}')) 
            -'msi'-'msnombrei'-'msedadi'-'entreaind'-'noreaind'-'ut9_esp'-'tel_ms'-'correo_ms'-'dia'-'ut1'-'ut2'-'ut3'-'d1'-'d2'-'ut4'-'fin_1'-'fin_2'-'ut3_esp'-'diario_sin_errores'-'diario_comenzado'-'modulo_1'
            )
            where enc=venc 
            */
            return (`Listo. Limpieza de I1 realizada en la persona ${params.persona} del hogar ${params.hogar} encuesta ${params.enc}. Por favor abra la encuesta, modifique observaciones, revise y justifique las inconsistencias`)
        }        
    },
    {
        action:'traer_actividades',
        parameters:[
        ],
        roles:['admin'],
        progress:true,
        coreFunction:async function(context:ProcedureContext, params: CoreFunctionParameters){
            var result = await context.client.query(
                `select *
                    from actividades_codigos order by codigo::text`,
                [ ]
            ).fetchAll(); 
            return result.rows;
        }    
    },
];
