import { IdFormulario, RespuestasRaiz, ForPk, IdVariable, Formulario, Libre, IdUnidadAnalisis, Respuestas,
    Valor,
    Estructura,
    PlainForPk,
    IdFin
} from "dmencu/dist/unlogged/unlogged/tipos";
import {getDatosByPass, persistirDatosByPass, setCalcularVariablesEspecificasOperativo, respuestasForPk, 
    registrarElemento, dispatchByPass, accion_registrar_respuesta
} from "dmencu/dist/unlogged/unlogged/bypass-formulario";
import {setLibreDespliegue} from "dmencu/dist/unlogged/unlogged/render-formulario";
import * as React from "react";
import { useDispatch } from "react-redux"; 
import { dispatchers } from "dmencu/dist/unlogged/unlogged/redux-formulario";
import { FormStructureState } from "row-validator";

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

type DataFromGrillaUTArray = Respuestas[]

setLibreDespliegue((props:{
    key:string
    casillero:Libre
    formulario:Formulario
    forPk:ForPk
})=>{
    const {casillero, formulario, forPk, key} = props;
    const id = casillero.id_casillero!;
    const dispatch = useDispatch();
    if(id == 'MODULO_1'){
        registrarElemento({
            id,
            direct:true,
            fun: function(respuestasAumentadas:Respuestas, _feedbackForm: FormStructureState<IdVariable,Valor,IdFin>, elemento:HTMLDivElement,
                _feedbackAll:{
                    [formulario in PlainForPk]:FormStructureState<IdVariable,Valor,IdFin> // resultado del rowValidator para estado.forPk
                },
                _estructura:Estructura
            ){
                var respuestas = respuestasAumentadas;
                if (elemento.grillaUt) return;
                elemento.innerHTML = "" ;
                var grillaUt = new GrillaUt(
                    (data:DataFromGrillaUTArray)=>{
                        dispatchByPass(
                            accion_registrar_respuesta, 
                            {
                                respuesta: data as unknown as Valor, 
                                variable: 'actividades' as IdVariable, 
                                forPk:props.forPk
                            }
                        );
                        dispatchByPass(
                            accion_registrar_respuesta, 
                            {
                                respuesta: grillaUt.acomodo.cargadoHasta=='24:00'?1:null, 
                                variable: 'modulo_1' as IdVariable, 
                                forPk:props.forPk
                            }
                        );
                        dispatchByPass(
                            accion_registrar_respuesta, 
                            {
                                respuesta: grillaUt.acomodo.agujeros.length?null:1, 
                                variable: 'diario_sin_errores' as IdVariable, 
                                forPk:props.forPk
                            }
                        );
                        dispatchByPass(
                            accion_registrar_respuesta, 
                            {
                                respuesta: data.length?1:null, 
                                variable: 'diario_comenzado' as IdVariable, 
                                forPk:props.forPk
                            }
                        );
                        
                        
                    },
                    ()=>{
                        dispatch(dispatchers.VOLVER_DE_FORMULARIO({magnitudRetroceso:1}))
                    }
                );
                grillaUt.cargar(respuestas['actividades' as IdUnidadAnalisis] || []);
                grillaUt.acomodar();
                var corYtotal=elemento.offsetTop;
                //cargar_otras_rta();
                grillaUt.desplegar(elemento.id,corYtotal);
                elemento.grillaUt = grillaUt;
            }
        });
    }
    return <div key={key} id={id}></div>
})
