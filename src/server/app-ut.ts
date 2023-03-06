"use strict";

import * as dmencu from "./types-ut";
import * as miniTools from "mini-tools";
import {Context, MenuInfoBase, Request, Response, OptsClientPage, TableDefinition } from "./types-ut";
import {defConfig} from "./def-config"
import {procedures} from "./procedures-ut"

import { actividades_codigos } from './table-actividades_codigos';
/* tablas ua
import { viviendas           } from './table-viviendas';
import { visitas             } from './table-visitas';
import { hogares             } from './table-hogares';
import { personas            } from './table-personas';
import { visitas_sup         } from './table-visitas_sup';
import { hogares_sup         } from './table-hogares_sup';
import { personas_sup        } from './table-personas_sup';
*/
const APP_DM_VERSION="#23-01-01";

export type Constructor<T> = new(...args: any[]) => T;
export function emergeAppUt<T extends Constructor<dmencu.AppAppDmEncuType>>(Base:T){
  return class AppUt extends Base{
    constructor(...args:any[]){ 
        super(args);
    }
    
    configStaticConfig(){
        super.configStaticConfig();
        this.setStaticConfig(defConfig);
    }

    async getProcedures(){
        var parentProc = await super.getProcedures()
        return parentProc.concat(procedures);
    }

    addSchrödingerServices(mainApp:dmencu.Express, baseUrl:string){
        let be=this;
        super.addSchrödingerServices(mainApp, baseUrl);
        //permito levantar mis imagenes en aplicaciones dependientes
        //be.app.use('/img', express.static('node_modules/dmencu/dist/unlogged/unlogged/img'))
        mainApp.get(baseUrl+'/grilla_ut',async function(req,res,_next){
            // @ts-ignore sé que voy a recibir useragent por los middlewares de Backend-plus
            var {useragent} = req;
            //var htmlMain=be.mainPage({useragent}, false, {skipMenu:true, offlineFile:true}).toHtmlDoc();
            //armar reg
            //miniTools.serveText(grilla_ut,'html')(req,res);
            miniTools.serveFile('dist/unlogged/grilla-ut/grilla-ut.html',{})(req,res);
        });
    }


    clientIncludes(req:Request, hideBEPlusInclusions:OptsClientPage){
        return super.clientIncludes(req, hideBEPlusInclusions).concat([
            { type: 'js', src: 'client/ut.js' },
            { type: 'js', src: 'my-bypass-formulario.js' },
            { type: 'js', src: 'my-render-formulario.js' },
            { type: 'js', src: 'grilla-ut.js' },
            { type: 'js', src: 'manual.js' },
            { type: 'js', src: 'actividades_codigos.js' },
            { type: 'js', src: 'grilla.js' },
            { type: 'css', file: 'grilla-ut.css'},
            { type: 'css', file: 'manual-ut.css'},
        ])
    }
    createResourcesForCacheJson(parameters){
        var be = this;
        var jsonResult = super.createResourcesForCacheJson(parameters);
        jsonResult.version = APP_DM_VERSION;
        jsonResult.appName = 'ut';
        jsonResult.cache=jsonResult.cache.concat([
            "my-render-formulario.js",
            'my-bypass-formulario.js'
        ])
        return jsonResult
    }
    getColorsJson(sufijo:'_test'|'_capa'|''){
        let miSufijo: '_prod'|'_test'|'_capa' = sufijo || '_prod';
        let coloresEntornos = {
            "_prod":"#067DB5",
            "_test":"#C47208",
            "_capa":"#880996",
        }
        return {
            "start_url": "../campo",
            "display": "standalone",
            "theme_color": "#3F51B5",
            "background_color": coloresEntornos[miSufijo]
        }
    }
    getMenu(context:Context){
        let menu:MenuInfoBase[] = [];
        if(this.config.server.policy=='web'){
            if(context.puede?.encuestas?.relevar){
                if(this.config['client-setup'].ambiente=='demo' || this.config['client-setup'].ambiente=='test' || this.config['client-setup'].ambiente=='capa'){
                    menu.push({menuType:'demo', name:'demo', selectedByDefault:true})
                }else{
                    menu.push({menuType:'path', name:'relevamiento', path:'/campo'})
                }
                menu.push(
                    {menuType:'sincronizar_dm', name:'sincronizar'},
                );
            }
        }else{
            if(context.puede?.campo?.editar){
                menu.push(
                    {menuType:'abrir_encuesta', name:'abrir_encuesta'},
                    {menuType:'abrir_grilla', name:'abrir_grilla'},
                    //{menuType:'consistir_encuesta', name:'consistir_encuesta'},
                )
                menu.push(
                    {menuType:'menu', name:'recepcion', label:'recepción' ,menuContent:[
                        {menuType:'table', name:'mis_areas', table:'areas', ff:{recepcionista:context.user.idper}},
                        {menuType:'table', name:'mis_encuestadores'},
                        {menuType:'table', name:'areas'},
                        {menuType:'table', name:'tem_recepcion', label:'TEM'},
                        {menuType:'table', name:'tareas_tem', label:'TareasTEM'}
                    ]},            
                )
            }
            console.log("context user", context.user)
            if(context.superuser){
                menu.push(
                    {menuType:'menu', name:'control', menuContent:[
                        {menuType:'table', name:'resumen', table:'control_resumen', selectedByDefault:true},
                        {menuType:'table', name:'dominio', table:'control_campo_dominio'},
                        {menuType:'table', name:'zona'   , table:'control_campo_zona'  },
                        {menuType:'table', name:'comuna' , table:'control_campo_comuna'},
                        {menuType:'table', name:'área'   , table:'control_campo_area'  },
                        {menuType:'table', name:'participacion'        , table:'control_campo_participacion'  },
                    ]},            
                )
            }
            /*
            if(context.puede?.encuestas.procesar){
                menu = [ ...menu,
                    {menuType:'menu', name:'procesar', menuContent:[
                        {menuType:'table', name:'variables'    },
                        {menuType:'table', name:'consistencias'},
                        {menuType:'table', name:'inconsistencias'},
                        {menuType:'table', name:'tabla_datos'  },
                        {menuType:'table', name:'diccionario'  , label:'diccionarios' },
                    ]},
                ]
            }
            */
            if(context.superuser){
                menu = [ ...menu,
                    {menuType:'menu', name:'configurar', menuContent:[
                        {menuType:'menu', name:'muestra', label:'muestra', menuContent:[
                            {menuType:'table', name:'tem', label: 'TEM'} ,
                            {menuType:'table', name:'tareas'},
                        ]},
                        {menuType:'menu', name:'metadatos', menuContent:[
                            {menuType:'table', name:'operativos'},
                            {menuType:'table', name:'formularios' , table:'casilleros_principales'},
                            {menuType:'table', name:'plano'       , table:'casilleros'},
                            {menuType:'table', name:'tipoc'       , label:'tipos de celdas'},
                            {menuType:'table', name:'tipoc_tipoc' , label:'inclusiones de celdas'},
                            
                        ]},
                        {menuType:'table', name:'actividades_codigos' , label:'actividades del Diario'},
                        {menuType:'table', name:'parametros'},
                    ]},
                    {menuType:'menu', name:'usuarios', menuContent:[
                        {menuType:'table', name:'usuarios', selectedByDefault:true},
                        {menuType:'table', name:'roles'},
                        {menuType:'table', name:'permisos'},
                        {menuType:'table', name:'roles_permisos'},
                    ]},
                    // {menuType:'proc', name:'generate_tabledef', proc:'tabledef_generate', label:'generar tablas'  },
                ]
            }
        }       
        return {menu};
    }
    prepareGetTables(){
        var be=this;
        super.prepareGetTables();
        this.getTableDefinition={
            ...this.getTableDefinition,
            actividades_codigos
            /* 
            viviendas,
            visitas,
            hogares,
            personas,
            visitas_sup,
            hogares_sup,
            personas_sup,
            */
        }

        be.appendToTableDefinition('tem',function(tableDef:TableDefinition, context:Context){
            tableDef.hiddenColumns=tableDef.hiddenColumns.filter(element => element !='semana');
           // console.log('camposhidden', tableDef.hiddenColumns )
            tableDef.fields.find((field)=>field.name=='semana')!.visible=true;
        });

        be.appendToTableDefinition('tareas_tem',function(tableDef:TableDefinition, context:Context){
            tableDef.hiddenColumns=tableDef.hiddenColumns.filter(element => element !='semana');
           // console.log('camposhidden', tableDef.hiddenColumns )
            tableDef.fields.push(
                {name:'semana'               , typeName:'integer' , editable: false, inTable: false },
            );
            tableDef.sql!.from = tableDef.sql!.from!.replace(
                'select tareas.tarea, t.operativo, t.enc, t.area',
                'select tareas.tarea, t.operativo, t.enc, t.area, t.semana '
            );
        })
        be.appendToTableDefinition('inconsistencias',function(tableDef:TableDefinition, context:Context){
            tableDef.sql.isTable=true;
            tableDef.editable=tableDef.editable || context.puede?.encuestas.justificar;
            tableDef.fields.forEach(function(field){
                if(field.name=='pk_integrada'){
                    field.visible=false;
                }
                if(field.name=='justificacion'){
                    field.editable=context.forDump || context.puede?.encuestas.justificar;
                }
            })
        })
    }
  }
}
