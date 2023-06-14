"use strict";

import * as dmencu from "./types-ut";
import * as miniTools from "mini-tools";
import {Context, MenuInfoBase, Request, Response, OptsClientPage, TableDefinition, 
        TableContext, MenuInfo, MenuDefinition, MenuInfoWScreen } from "./types-ut";
import {defConfig} from "./def-config"
import {procedures} from "./procedures-ut"

import { actividades_codigos } from './table-actividades_codigos';
/* tablas ua */
import { viviendas           } from './table-viviendas';
import { visitas             } from './table-visitas';
import { hogares             } from './table-hogares';
import { personas            } from './table-personas';
import { actividades         } from './table-actividades';
import { visitas_sup         } from './table-visitas_sup';
import { hogares_sup         } from './table-hogares_sup';
import { personas_sup        } from './table-personas_sup';

const APP_DM_VERSION="#23-06-14";

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
            { type: 'css', file: 'grilla-ut.css'},
            { type: 'css', file: 'manual-ut.css'},
        ])
    }
    createResourcesForCacheJson(parameters:Record<string,any>){
        var be = this;
        var jsonResult:any = super.createResourcesForCacheJson(parameters);
        jsonResult.version = APP_DM_VERSION;
        jsonResult.appName = 'ut';
        jsonResult.cache=jsonResult.cache.concat([
            "my-render-formulario.js",
            'my-bypass-formulario.js',
            'grilla-ut.js',
            'manual.js',
            'actividades_codigos.js',
            'css/grilla-ut.css',
            'css/manual-ut.css',
            'img/grilla.svg'
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
        return super.getMenu(context);
    }
    prepareGetTables(){
        var be=this;
        super.prepareGetTables();
        this.getTableDefinition={
            ...this.getTableDefinition,
            actividades_codigos,
            viviendas,
            visitas,
            hogares,
            personas,
            actividades,
            visitas_sup,
            hogares_sup,
            personas_sup,
        }
        be.appendToTableDefinition('tem',function(tableDef:TableDefinition, _context?:TableContext){
            tableDef.hiddenColumns=tableDef.hiddenColumns?.filter(element => element !='semana');
           // console.log('camposhidden', tableDef.hiddenColumns )
            tableDef.fields.find((field)=>field.name=='semana')!.visible=true;
        });
        be.appendToTableDefinition('tareas_tem',function(tableDef:TableDefinition, _context?:TableContext){
            tableDef.hiddenColumns=tableDef.hiddenColumns?.filter(element => element !='semana');
           // console.log('camposhidden', tableDef.hiddenColumns )
            tableDef.fields.push(
                {name:'semana'               , typeName:'integer' , editable: false, inTable: false },
            );
            tableDef.sql!.from = tableDef.sql!.from!.replace(
                'select tt.tarea, t.operativo, t.enc, t.area',
                'select tt.tarea, t.operativo, t.enc, t.area, t.semana '
            );
        })
        be.appendToTableDefinition('inconsistencias',function(tableDef:TableDefinition, context?:TableContext){
            tableDef.sql={...tableDef.sql, isTable:true};
            tableDef.editable=tableDef.editable || context?.puede?.encuestas.justificar;
            //agregar campo renglon, pk agregada de actividades
            tableDef.fields.splice(5,0,
                {name:'renglon'     , typeName:'bigint'   , editable: false},
            );
            tableDef.fields.forEach(function(field){
                if(field.name=='pk_integrada'){
                    field.visible=false;
                }
                if(field.name=='justificacion'){
                    field.editable=context?.forDump || context?.puede?.encuestas.justificar;
                }
            })
        })
        be.appendToTableDefinition('areas', function(tableDef){
            tableDef.selfRefresh = true;
            tableDef.refrescable = true;
        });
    }
  }
}
