import { IdFormulario, RespuestasRaiz, ForPk, IdVariable, DatosHdrUaPpal, Formulario, Libre } from "dmencu/dist/unlogged/unlogged/tipos";
import {getDatosByPass, setCalcularVariablesEspecificasOperativo, respuestasForPk} from "dmencu/dist/unlogged/unlogged/bypass-formulario";
import {setLibreDespliegue} from "dmencu/dist/unlogged/unlogged/render-formulario";
import {html} from "js-to-html";
import * as React from "react";
import { useLayoutEffect } from "react";

setCalcularVariablesEspecificasOperativo((respuestasRaiz:RespuestasRaiz, forPk:ForPk)=>{
    //ajustar variables
    if(forPk.formulario == 'F:S1_SUP' as IdFormulario){
        let hogar = forPk.hogar as number - 1;
        if(respuestasRaiz.hogares && respuestasRaiz.hogares[hogar]){
            let respuestasHogarSup = respuestasRaiz.hogares_sup[hogar];
            let respuestasHogar = respuestasRaiz.hogares[hogar];
            respuestasHogarSup.resp_indi_sup = respuestasHogar.msnombre;
            if(respuestasHogar.personas && respuestasHogar.personas instanceof Array){
                respuestasHogarSup.resp_comp_ed_sup = respuestasHogar.personas[0]?.edad;
                respuestasHogarSup.resp_comp_sup = respuestasHogar.personas[0]?.nombre;
                respuestasHogarSup.resp_indi_ed_sup = 
                    respuestasHogar.cr_num_miembro?
                        respuestasHogar.personas[respuestasHogar.cr_num_miembro -1]?.edad
                    :null;
            }
        }
    }
    if(forPk.formulario == 'F:I1' as IdFormulario){
        let {respuestas} = respuestasForPk(forPk);
        respuestas['msi' as IdVariable] = respuestas['$p0' as IdVariable];
        respuestas['msnombrei' as IdVariable] = respuestas['nombre' as IdVariable];
        respuestas['msedadi'as IdVariable] = respuestas['edad' as IdVariable];
    }
})

setLibreDespliegue((props:{
    key:string
    casillero:Libre
    formulario:Formulario
    forPk:ForPk
})=>{
    useLayoutEffect(() => {
        var grillaUt = new GrillaUt();
        var datos_matriz=[{"desde":"00:00","hasta":"07:00","codigo":"922","detalle":null},{"desde":"07:00","hasta":"07:30","codigo":"911","detalle":null},{"desde":"07:30","hasta":"08:00","codigo":"31","detalle":null},{"desde":"08:00","hasta":"08:30","codigo":"921","detalle":null},{"desde":"08:30","hasta":"09:00","codigo":"14","detalle":null},{"desde":"09:00","hasta":"18:00","codigo":"1","detalle":"Declara que no paró a almorzar."},{"desde":"18:00","hasta":"18:30","codigo":"14","detalle":null},{"desde":"18:30","hasta":"19:00","codigo":"911","detalle":null},{"desde":"19:00","hasta":"20:00","codigo":"36","detalle":null},{"desde":"20:00","hasta":"22:00","codigo":"32","detalle":null},{"desde":"21:00","hasta":"21:30","codigo":"33","detalle":null},{"desde":"22:00","hasta":"23:00","codigo":"921","detalle":null},{"desde":"22:00","hasta":"22:30","codigo":"31","detalle":null},{"desde":"23:00","hasta":"24:00","codigo":"922","detalle":null}];
        grillaUt.cargar(datos_matriz);
        grillaUt.acomodar();
        var misDatosByPass = getDatosByPass();
        var corYtotal=document.getElementById(props.casillero.id_casillero)!.offsetTop;
        //cargar_otras_rta();
        grillaUt.desplegar(props.casillero.id_casillero,corYtotal);
    });
    return <div key={props.key} id={props.casillero.id_casillero}></div>
})