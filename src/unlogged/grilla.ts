import * as GrillaUt from './grilla-ut.js';
import {getDatosByPass} from "dmencu/dist/unlogged/unlogged/bypass-formulario";

myOwn.wScreens.abrir_grilla={
    parameters:[],
    autoproced:true,
    mainAction:async (_params)=>{
        //menu#w=abrir_grilla&up={}&autoproced=true (podes llamar al boton con esta url)
        var variable_especial='actividades';
        var grillaUt = new GrillaUt();
        var datos_matriz=[{"desde":"00:00","hasta":"07:00","codigo":"922","detalle":null},{"desde":"07:00","hasta":"07:30","codigo":"911","detalle":null},{"desde":"07:30","hasta":"08:00","codigo":"31","detalle":null},{"desde":"08:00","hasta":"08:30","codigo":"921","detalle":null},{"desde":"08:30","hasta":"09:00","codigo":"14","detalle":null},{"desde":"09:00","hasta":"18:00","codigo":"1","detalle":"Declara que no paró a almorzar."},{"desde":"18:00","hasta":"18:30","codigo":"14","detalle":null},{"desde":"18:30","hasta":"19:00","codigo":"911","detalle":null},{"desde":"19:00","hasta":"20:00","codigo":"36","detalle":null},{"desde":"20:00","hasta":"22:00","codigo":"32","detalle":null},{"desde":"21:00","hasta":"21:30","codigo":"33","detalle":null},{"desde":"22:00","hasta":"23:00","codigo":"921","detalle":null},{"desde":"22:00","hasta":"22:30","codigo":"31","detalle":null},{"desde":"23:00","hasta":"24:00","codigo":"922","detalle":null}];
        grillaUt.cargar(datos_matriz);
        grillaUt.acomodar();
        var misDatosByPass = getDatosByPass();
        var mainLayout = document.getElementById('main_layout')!;
        var corYtotal=mainLayout.offsetTop;
        //cargar_otras_rta();
        grillaUt.desplegar(mainLayout.id,corYtotal);
    }
};