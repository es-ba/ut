"use strict";

import { TypedControl } from "typed-controls";

export type Actividades_codigos = { 
    codigo: Actividad
    texto: string
    abr: string
    detalle: string
    //imagen_ver: string
    exclusividad: boolean
    obligatoriedad:boolean
    opcion_d12: boolean
    opcion_d13: boolean
    opcion_d22: boolean
    opcion_d23: boolean
    color: string
    rescatable: boolean
    imagen_path: string
    nombre_variable: string
    grupo:string
}

var defPreguntasRescate=[
    {pre:'D1', "var":'d1'},
    {pre:'D2', "var":'d2'}
];

// para no repetir los textos porque son siempre iguales, si no lo son no usar esta variable
var textosDeCuidado = {
    pregunta: "¿Cuál fue el motivo del cuidado?",
    personal: "personal",
    salud: "razones de salud",
    escolar: "apoyo escolar",
    traslados: "traslados",
    otro: "algún otro tipo"
}

type PreguntaActividad = {
    pregunta: string
    opciones: {opcion:string, texto:string, aclaracion?:string}[]
    rescate?: {codigo:string, texto:string, aclaracion?:string}[]
}

var preguntasActividad: Record<string, PreguntaActividad> = {
    "4":{
        pregunta: "¿Cuido a una persona...",
        opciones: [
            {opcion: "1", texto: "con discapacidad?"},
            {opcion: "2", texto: "de 0 a 13 años de edad?"},
            {opcion: "3", texto: "de 14 a 64 años de edad?"},
            {opcion: "4", texto: "de 65 años de edad o más?"}
        ],
        rescate: [
            {codigo: "11", texto: "si el cuidado es un trabajo remunerado a miembros de otro hogar"},
            {codigo: "51", texto: "si el cuidado es un trabajo remunerado a miembros de otro hogar"}
        ]
    },
    "41":{
        pregunta: textosDeCuidado.pregunta,
        opciones: [
            {opcion: "1", texto: textosDeCuidado.personal},
            {opcion: "2", texto: textosDeCuidado.salud},
            {opcion: "3", texto: textosDeCuidado.escolar},
            {opcion: "4", texto: textosDeCuidado.traslados},
            {opcion: "9", texto: textosDeCuidado.otro},
        ]
    },
    "42":{
        pregunta: textosDeCuidado.pregunta,
        opciones: [
            {opcion: "1", texto: textosDeCuidado.personal},
            {opcion: "2", texto: textosDeCuidado.salud},
            {opcion: "3", texto: textosDeCuidado.traslados},
            {opcion: "9", texto: textosDeCuidado.otro},
        ]
    },
    "43":{
        pregunta: textosDeCuidado.pregunta,
        opciones: [
            {opcion: "1", texto: textosDeCuidado.personal},
            {opcion: "2", texto: textosDeCuidado.salud},
            {opcion: "3", texto: textosDeCuidado.traslados},
            {opcion: "9", texto: textosDeCuidado.otro},
        ]
    },
    "44":{
        pregunta: textosDeCuidado.pregunta,
        opciones: [
            {opcion: "1", texto: textosDeCuidado.personal},
            {opcion: "2", texto: textosDeCuidado.salud},
            {opcion: "3", texto: textosDeCuidado.traslados},
            {opcion: "9", texto: textosDeCuidado.otro},
        ]
    },
    // /* comentar desde la siguiente línea si no se quiere ver la propuesta extendida
    "":{
        pregunta: "¿Qué hizo?",
        opciones:[
            {opcion:"1", texto: "trabajar para un patrón o cuenta propia", aclaracion: "(o viajar al... o buscar... trabajo)"},
            {opcion:"2", texto: "trabajar para autoconsumo o uso propio del hogar"},
            {opcion:"3", texto: "actividades para el hogar o la vivienda"},
            {opcion:"4", texto: "cuidado a personas del hogar"},
            {opcion:"5", texto: "ayuda a otros hogares o trabajo voluntario"},
            {opcion:"6", texto: "aprendizaje o estudio", aclaracion: "incluye el viaje"},
            {opcion:"7", texto: "vida social, eventos culturales, deporte"},
            {opcion:"8", texto: "esparcimiento individual"},
            {opcion:"9", texto: "aseo, salud, descanso, dormir y otros"},
            {opcion:"0", texto: "viajes y traslados", aclaracion: "debe registrarse en la actividad relacionada"}
        ]
    },
    "1":{
        pregunta: "¿Qué hizo?",
        opciones: [
            {opcion: "1", texto: "Trabajar para un patrón o por cuenta propia"},
            {opcion: "3", texto: "Buscar trabajo"},
            {opcion: "4", texto: "Viajar para ir y volver al trabajo"},
        ],
        rescate: [
            {codigo: "2", texto: "si el trabajo es para autoconsumo o para uso propio del hogar"},
            {codigo: "51", texto: "si cuida a personas de otro hogar de forma no remunerada"},
        ]
    },
    "3":{
        pregunta: "¿Qué hizo?",
        opciones: [
            {opcion: "1", texto: "Preparar y servir la comida"},
            {opcion: "2", texto: "Limpiar la vivienda"},
            {opcion: "3", texto: "Lavar, planchar o arreglar la ropa"},
            {opcion: "4", texto: "Hacer reparaciones y mantenimiento de la vivienda"},
            {opcion: "5", texto: "Hacer pagos y trámites del hogar"},
            {opcion: "6", texto: "Hacer compras para el hogar"},
            {opcion: "7", texto: "Cuidar mascotas y plantas"},
        ],
        rescate: [
            {codigo: "4", texto: "si cuidó personas del hogar"},
            {codigo: "2", texto: "si cultivó, crió o fabricó algo para el hogar"},
        ]
    },
    "5":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "1", texto:"Ayuda a otros hogares (trabajo no remunerado para otros hogares)", aclaracion: "ej: cuidado a personas o tareas domésticas en otro hogar"},
            {opcion: "4", texto:"Trabajo voluntario ", aclaracion: "en instituciones, comunidades, etc"},
        ]
    },
    "6":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "1", texto: "Aprendizaje y estudio"}, 
            {opcion: "2", texto: "Traslados para aprendizaje y estudio"}, 
        ]
    },
    "7":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "11", texto: "Reunirse con familiares o amigos"},
            {opcion: "12", texto: "Participar de celebraciones comunitarias, políticas o religiosas"},
            {opcion: "2", texto: "Eventos culturales y deportivos"},
            {opcion: "3", texto: "Actividades artísticas, juegos o entretenimientos"},
            {opcion: "4", texto: "Deporte y ejercicio físico"},
        ]
    },
    "71":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "1", texto: "Reunirse con familiares o amigos"},
            {opcion: "2", texto: "Participar de celebraciones comunitarias, políticas o religiosas"},
        ]
    },
    "8":{
        pregunta: "¿Qué hizo?",
        opciones: [
            {opcion: "1", texto:"Lectura de libros, revistas, etc."},
            {opcion: "2", texto:"Ver televisión "},
            {opcion: "3", texto:"Escuchar música o radio"},
            {opcion: "4", texto:"Usar computadora, tableta o celular"},
        ]
    },
    "9":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "11", texto:"Aseo y arreglo personal"},
            {opcion: "12", texto:"Cuidados personales de salud"},
            {opcion: "19", texto:"Viajar para cuidar su salud"},
            {opcion: "14", texto:"Descanso, relajación, otras actividades personales"},
            {opcion: "21", texto:"Comer, beber, ir al baño."},
            {opcion: "22", texto:"Dormir"},
            {opcion: "99", texto:"Otro", aclaracion: "Cualquier otra actividad que no esté comprendida en las categorías anteriores. (No olvide anotar)"},
        ]
    },
    "91":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "1", texto:"Aseo y arreglo personal"},
            {opcion: "2", texto:"Cuidados personales de salud"},
            {opcion: "9", texto:"Viajar para cuidar su salud"},
            {opcion: "4", texto:"Descanso, relajación, otras actividades personales"},
        ]
    },
    "92":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "1", texto:"Comer, beber, ir al baño."},
            {opcion: "2", texto:"Dormir"},
        ]
    },
    "99":{
        pregunta: "¿Qué hizo?",
        opciones: [ 
            {opcion: "9", texto:"Otro", aclaracion: "Cualquier otra actividad que no esté comprendida en las categorías anteriores. (No olvide anotar)"},
        ]
    },
    "0":{
        pregunta: "las actividades viaje o traslado deben consignarse en los códigos de las actividades correspondientes",
        opciones: [ 
        ],
        rescate: [
            {codigo: "14", texto: "viajar para ir y volver al trabajo"},
            {codigo: "2", texto: "relacionado a trabajar para autoconsumo o uso propio del hogar"},
            {codigo: "3", texto: "relacionado a actividades para el hogar o la vivienda"},
            {codigo: "4", texto: "relacionado a cuidado a peronas del hogar"},
            {codigo: "5", texto: "relacionado a ayuda a otros hogares o trabajo voluntario"},
            {codigo: "62", texto: "traslados para aprendizaje y estudio"},
            {codigo: "7", texto: "relacionado a vida social, eventos culturales, deporte"},
            {codigo: "8", texto: "relacionado a esparcimiento individual"},
            {codigo: "9", texto: "relacionado a aseo, salud, descanso, dormir y otros"},
        ]
    }
}

import * as jsToHtml from 'js-to-html';
import * as TypedControls from 'typed-controls';
import * as json4all from 'json4all';
import * as likeAr from 'like-ar';

declare global {
    interface HTMLTableRowElement{
        numeroOrdenFila:number
    }
}

var html = jsToHtml.html;

function recontarFilas(tabla:HTMLTableElement){
    Array.prototype.forEach.call(tabla.childNodes, function(child, i){
        child.numeroOrdenFila=i;
    });
}

var O_map = <T,V>(object:Record<string, T>, callback:(value:T, key:string, object:Record<string,T>)=>V) => {
    return Object.keys(object).map(function(key){
        return callback(object[key], key, object);
    })
}

var tramo: never
var tramos: never

type DosD = '00' | '01' | '02' | '10' | '20' 

type Hora = `${DosD}:${DosD}` | '24:00'

type Actividad = '1' | '411' | '412' | 'etc'

// type Hora = '00:00' | '00:10' | '01:00' | '02:00' | 'etc'

type Tramo = {
    desde:Hora|null
    hasta:Hora|null
    rescate:string|null
    codigo:Actividad|null
    detalle:string|null
}

type TramoExtendido = Tramo & {
    inputs:Record<keyof Tramo, TypedControl<any>>
    rescatable:boolean
} & Record<CorteId,HTMLDivElement & Tramo>

type EstructuraTramo = {
    nombre:keyof Tramo
    tipo:string
    completador:(s:string|null)=>string|null
    validador:(valor:Tramo[keyof Tramo], tramo:Tramo)=>boolean
    actualizaPlaceholder?:keyof Tramo
    tabindex?:boolean
    rescate?:boolean
    titulo?:string
}

type IdColumna = 0|1|2|'agujero'
type CorteId = 'caja1' | 'caja2'
type Agujero = Partial< Tramo & Record<CorteId, HTMLElement> >

type GruillaUtThis = {
    tramos: Tramo[]
    estructuraTramo: EstructuraTramo[]
    renglonVacio: () => Tramo
    separaHoraTexto: (horaNoSeparada:Hora) => {hora:DosD, minutos:DosD}
    completarHora: (horaIncompleta:string|null) => Hora|null
    validarHora: (hora:string) => boolean
    validarHoraYRango: (hora:string|boolean|null, rango:Tramo) => boolean
    validarActividad: (actividad:string|boolean|null) => boolean
    cargar: (tramos:Tramo[]) => void
    acomodar: () => void
    acomodo: {
        columnas:TramoExtendido[][],
        agujeros:Agujero[],
        cargadoHasta:Hora|null
    }
    habilitarRescate: (tramo:Partial<TramoExtendido>) => void
    desplegar: (idDiv:string, corYtotal:number) => void
    desplegarRenglon: (tramo:Partial<TramoExtendido>, i:number) => void
    desplegar_izquierda: (idDiv:string, corYtotal:number) => void
    desplegar_rescate: () => void
}

class PantallaAyuda{
    elemento: HTMLDivElement
    id = 'pantalla-ayuda-grilla'
    ocultando:boolean = false
    // @ts-expect-error el valor se setea en colocar
    gu: GruillaUtThis
    constructor(){
        this.elemento = html.div({id:this.id, class:"grilla-actividades"}).create();
    }
    colocar(grilla:GruillaUtThis){
        this.gu = grilla;
        var existente = document.getElementById(this.id);
        if (existente) {
            existente.parentNode?.removeChild(existente);
        }
        document.body.appendChild(this.elemento);
    }
    mostrarOpcion(input:TypedControl<string>, valor:string, o:{opcion?:string, codigo?:string, texto:string, aclaracion?:string}, i_tramo:number){
        var opcion = html.p({class:"grilla-opcion"}, [
            html.span(o.codigo ?? o.opcion),
            html.span(" - "),
            html.span(o.texto),
            ...(o.aclaracion ? [
                html.span([" ", html.small(o.aclaracion)])
            ] : [])
        ]).create();
        opcion.addEventListener('mousedown', (event)=>{
            event.preventDefault();
        })
        opcion.addEventListener('click', ()=>{
            var nuevoValor = o.codigo ?? (valor ?? "") + o.opcion
            input.setTypedValue(nuevoValor, true);
            this.mostrar(input, i_tramo);
        })
        return opcion
    }
    mostrar(input:TypedControl<string>, i_tramo:number){
        var valor = input.getTypedValue();
        var preguntaActividad = preguntasActividad[valor||""];
        var tramo = this.gu.tramos[i_tramo];
        if(preguntaActividad != null){
            var seccionContinuadora:HTMLElement[] = []
            var textoPregunta = valor ? preguntaActividad.pregunta : (
                !tramo.desde ? "Hasta las " + this.gu.acomodo.cargadoHasta + ", ¿realizó alguna otra actividad? ¿cuál?" :
                !tramo.hasta ? "Desde las " + tramo.desde + " ¿qué acividad realizó?" : 
                "Desde las " + tramo.desde + " hasta las " + tramo.hasta + " ¿qué acividad realizó?"
            )
            var elementoPregunta = html.p({class:"grilla-pregunta", $attrs:{"leer-pregunta":"si"}}, textoPregunta).create();
            if(!tramo.desde && this.gu.acomodo.cargadoHasta && !valor){
                var continuadora = html.p({class:"grilla-opcion"}, "No, no realizó otra actividad simultáneamente hasta esa hora").create();
                continuadora.addEventListener('mousedown', (event) => {
                    event.preventDefault();
                });
                continuadora.addEventListener('click', () => {
                    (tramo as TramoExtendido).inputs.desde.setTypedValue(this.gu.acomodo.cargadoHasta, true);
                    elementoPregunta.textContent = "Desde las " + this.gu.acomodo.cargadoHasta + " ¿qué actividad realizó?"
                    continuadora.style.visibility = "hidden";
                })
                seccionContinuadora.push(continuadora)
            }
            this.elemento.innerHTML = "";
            this.elemento.appendChild(html.div([
                elementoPregunta,
                ...seccionContinuadora,
                ...(preguntaActividad.opciones.map( o => this.mostrarOpcion(input, valor, o, i_tramo) )), 
                ...(preguntaActividad.rescate ? [
                    html.p({class:'atencion-ayuda-diario'},"ATENCIÓN, cambie el código por"),
                    ...(preguntaActividad.rescate.map( o => this.mostrarOpcion(input, valor, o, i_tramo) ))
                    ] : [])
            ]).create())
            this.elemento.style.display = "block";
        } else {
            this.ocultar()
        }
    }
    ocultar(){
        this.elemento.style.display = "none";
    }
}

function GrillaUt(
    grabarFun: (data:any) => void,
    cerrarFun: () => void
){
    var colorOtros='#49FFFF77';
    var colorInvalido='#FFED66';
    var colorAgujero='rgba(255,0,0,0.5)'
    // @ts-expect-error es una variable global
    var actividades_codigos: Record<Actividad, Actividades_codigos> = window.actividades_codigos;
    // @ts-expect-error es una variable global
    var actividades_svg: Record<Actividad, string> = window.actividades_svg;
    // @ts-expect-error no conocemos el tipo de t his, así que vamos a usar gu
    var gu: GruillaUtThis = this;
    function grabar_todo(){
        var tramos_a_grabar=gu.tramos.map(function(tramo:Tramo){
            return likeAr(gu.renglonVacio()).map((_, key)=>tramo[key]).plain();
        }).filter(function(tramo){
            return tramo.desde || tramo.hasta || tramo.codigo || tramo.detalle;
        });
        var datos_matriz_json=json4all.stringify(tramos_a_grabar);
        grabarFun(json4all.parse(datos_matriz_json));
        //230213 rta_ud['var_'+variable_especial]=datos_matriz_json;
        //23/2/9 localStorage.setItem("ud_"+id_ud, JSON.stringify(rta_ud)); graba en el json del localstorage
    }
    gu.renglonVacio=function(){ return {desde:null, hasta:null, codigo:null, detalle:null, rescate:null}; };
    var medidas={
        horas:12,
        renglonesHora:6,
        pixelPorRenglon:10,
        pixelAncho:120,
        minutosRenglon:10,
        cantAct:3,
        separacionActividad:4,
    };
    var cortes = [
        //SETEO corY=0 para que se vea bien. Estaba en -10 y arruinaba la posición
        {id: 'caja1' as CorteId, desde:'00:00' as Hora, hasta:'12:00' as Hora, corX:15 , corY: -10},
        {id: 'caja2' as CorteId, desde:'12:00' as Hora, hasta:'24:00' as Hora, corX:205, corY: -10-medidas.horas*medidas.renglonesHora*medidas.pixelPorRenglon},
    ]
    var novalidar=function(){return true;}
    var nocompletar=function<T>(x:T){ return x;}
    gu.separaHoraTexto=function(horaNoSeparada){
        var indiceDosPuntos=horaNoSeparada.match(/:/)?.index ?? horaNoSeparada.length;
        var preDosPuntos=horaNoSeparada.substr(0,indiceDosPuntos) as DosD;
        var postDosPuntos=horaNoSeparada.substr(indiceDosPuntos+1,horaNoSeparada.length) as DosD;
        return {
            hora:preDosPuntos,
            minutos:postDosPuntos
        };
    }
    gu.completarHora = function completarHora(hora:string|null){
        if(hora==null) return null;
        if(!hora.match(/:/) && hora.match(/[,.;]/)){
            hora=hora.replace(/[,.;]/,':')
        }
        if(!hora.match(/:/)){
            if(hora.length<=2){
                hora=hora+':00';
            }else{
                hora=hora.substr(0,hora.length-2)+':'+hora.slice(-2);
            }
        }
        var horaSeparada=gu.separaHoraTexto(hora as Hora);
        hora=(horaSeparada.hora.length==1)?'0'+hora:hora;
        horaSeparada=gu.separaHoraTexto(hora as Hora);
        hora=(horaSeparada.minutos.length==0)?hora+'00':hora;
        hora=(horaSeparada.minutos.length==1)?hora+'0':hora;
        hora=(horaSeparada.minutos.length>2)?horaSeparada.hora+':'+horaSeparada.minutos.substr(0,2):hora;
        return hora as Hora;
    };
    gu.validarHora = function validarHora(hora){
        var patt = new RegExp(/^([01]\d|2[0-3]):([0-5][0-9])$/);
        return patt.test(hora) || (hora=='24:00');
    };
    gu.validarHoraYRango = function (hora, registroConDesdeHasta){
        var desde=registroConDesdeHasta.desde;
        var hasta=registroConDesdeHasta.hasta;
        var rangoInvalido = hasta != null && desde != null && hasta<=desde;
        return this.validarHora(hora as string) && !rangoInvalido;
    }
    gu.validarActividad = function validarActividad(actividad){
      //  return !!codigosActividad[actividad];
        return !!actividades_codigos[actividad as Actividad];        
    };
    gu.estructuraTramo=[
        {nombre:'codigo' ,tipo:'tel' , completador:nocompletar     , validador:gu.validarActividad , actualizaPlaceholder:'detalle', titulo: 'act'},
        {nombre:'rescate',tipo:'tel' , completador:nocompletar     , validador:novalidar           , tabindex:true, rescate:true, titulo: 'R'},
        {nombre:'desde'  ,tipo:'tel' , completador:gu.completarHora, validador:gu.validarHoraYRango},
        {nombre:'hasta'  ,tipo:'tel' , completador:gu.completarHora, validador:gu.validarHoraYRango},
        {nombre:'detalle',tipo:'text', completador:nocompletar     , validador:novalidar           , tabindex:true, titulo: 'observaciones'},
    ]
    gu.cargar = function cargar(tramos){
        gu.tramos = tramos.map(tramo=>({...tramo})); // Necesitamos una copia porque la pantalla toca los tramos poniendo un montón de punteros
        if(!this.tramos.length || this.tramos[this.tramos.length-1].desde){
            //ESTO TRAE PROBLEMAS CON EL TEST QUE NO HACE QUE NO PASE EL TEST DE ACOMODAR RENGLÓN: NO CONTEMPLA ACOMODAR EL RENGLÓN VACÍO
            this.tramos.push(this.renglonVacio());
        }
    }
    gu.acomodar = function acomodar(){
        var gu = this;
        var tramos = this.tramos as TramoExtendido[];
    /* separa los tramos en una o más columnas de modo de que:
        1) cada tramo esté en alguna columna
        2) dentro de cada columna los tramos estén ordenados
        3) dentro de cada columna los tramos no se superpongan
        4) se empiece llenando siempre la primera columna, luego la segunda, etc
       además calcula los agujeros (rangos horarios sin tramos) y
       el fin del tramo que termina último
    */  
        if(gu.acomodo){
            this.acomodo.agujeros.forEach(function(agujero){
                cortes.forEach(function(corte){
                    var elementoDeCorte = agujero[corte.id]
                    if(elementoDeCorte != null){
                        elementoDeCorte.parentNode?.removeChild(elementoDeCorte);
                    }
                });
            });
        }
        this.acomodo = {
            columnas:[],
            agujeros:[],
            cargadoHasta:'' as Hora
        };
        var ancho = function(c:string|null){
            if(c==null){
                return 'zzzzzzzzzz';
            }
            while(c.length<10) c+=' ';
            return c;
        }
        var invertir = function(t:string){
            return t.split('').map(function(letra){
                return String.fromCharCode('|'.charCodeAt(0)-letra.charCodeAt(0));
            }).join('');
        }
        var lindo = function(x:Tramo){
            return ancho(x.desde)+'/'+invertir(ancho(x.hasta))+'/'+x.codigo
        }
        tramos.sort(function(x,y){
            var xLindo=lindo(x);
            var yLindo=lindo(y);
            if(xLindo<yLindo){
                return -1;
            }else if(xLindo>yLindo){
                return 1;
            }else{
                return 0;
            }
        })
        this.acomodo.cargadoHasta = tramos[tramos.length-1].hasta;
        var columnas = this.acomodo.columnas;
        columnas.push([tramos[0] as TramoExtendido]);
        var actual;
        for(var i=1;i<tramos.length;i++){
            actual=tramos[i];
            var j=0;
            var ubicado= false;
            while (j<columnas.length){
                var colj=columnas[j];
                var cotacol=colj[colj.length-1];
                if ( (actual.desde ?? 'z') >= (cotacol.hasta ?? 'z') ){
                    columnas[j].push(actual);
                    j=columnas.length;
                    ubicado=true;
                }
                j++;
            }
            if(!ubicado){
                columnas.push([actual]);
            }
        }
        var agujeros=[] as Agujero[];
        var desde = tramos[0].desde;
        if ( desde != null && desde > '00:00'){
            agujeros.push({desde:'00:00', hasta: desde});
        };
        var cargado_total = tramos[0].hasta ?? 'z' as Hora;
        for(var i=1;i<tramos.length;i++){
            if ( (tramos[i].desde ?? '') > cargado_total ){
                var agujero = {} as Tramo;
                agujero.desde = cargado_total;
                agujero.hasta = tramos[i].desde;
                agujeros.push(agujero);
            } 
            var hasta = tramos[i].hasta
            cargado_total = hasta != null && cargado_total < hasta ? hasta : cargado_total;
        }
        this.acomodo.agujeros = agujeros;
        
        this.acomodo.cargadoHasta=cargado_total;
    }
    gu.habilitarRescate = function habilitarRescate(tramo){
        //230213 tramo.rescatable=tramo.codigo && (rta_ud.var_d1==1 || rta_ud.var_d2==1) && actividades_codigos[tramo.codigo]&& actividades_codigos[tramo.codigo].rescatable ;
        tramo.inputs!.rescate.style.visibility=tramo.rescatable?'visible':'hidden';
    }
    gu.desplegar = function desplegar(idDivDestino, corYtotal){
        var gu = this;
        var pantallaAyuda = new PantallaAyuda();
        pantallaAyuda.colocar(gu);
        corYtotal=corYtotal||0;
        var tabla=html.table({id:'grilla-ut-tabla-externa'},[
            html.tr([
                html.td({id:'grilla-ut-zona-izquierda'}),
                html.td({id:'grilla-ut-zona-derecha'}),
            ])
        ]);
        document.getElementById(idDivDestino)!.appendChild(tabla.create());        
        var renglones_tramos=[];
        renglones_tramos.push(html.tr(
            gu.estructuraTramo.map(c => html.th({"class":"col-"+c.nombre  }, c.titulo ?? c.nombre ))
        ));
        var tablaTramos=html.table(renglones_tramos).create();
        var hastaDonde='';
        document.getElementById('grilla-ut-zona-derecha')!.appendChild(tablaTramos);
        gu.desplegarRenglon = function(tramo, i_tramo){
            var celdas=[];
            tramo.inputs = {} as TramoExtendido['inputs'];
            var classToggle=function(input:HTMLInputElement, clase:string, sacoAgrego:boolean){
                if(sacoAgrego){
                    input.classList.add(clase);
                }else{
                    input.classList.remove(clase);
                } 
            }
            var agregarPlaceholder=function(_input:HTMLInputElement, infoCampo:EstructuraTramo){
                if(infoCampo.actualizaPlaceholder){
                   // var infoActividad = codigosActividad[tramo.codigo];
                    var infoActividad = actividades_codigos[tramo.codigo!];
                    (tramo.inputs?.[infoCampo.actualizaPlaceholder] as unknown as HTMLInputElement).placeholder = infoActividad != null?infoActividad.abr:'';
                }
            }
            var validarInput=function validarInput(control:TypedControl<any> | null, infoCampo:EstructuraTramo){
                if(control != null){
                    var valor = control.getTypedValue();
                    var input = control as unknown as HTMLInputElement;
                    var invalido = valor==null?false: !infoCampo.validador.call(gu, valor, tramo as Tramo);
                    classToggle(input,'edit-warning',invalido) 
                    agregarPlaceholder(input, infoCampo);
                }
            }
            var validarTramo=function validarTramo(){
                gu.estructuraTramo.forEach(function(infoCampo){
                    validarInput(tramo.inputs![infoCampo.nombre], infoCampo);
                });
                gu.habilitarRescate(tramo);
                /* 230213
                var save_rta_ud=rta_ud;
                //23/2/9 para armado de pk?????
                copia_ud.copia_enc=pk_ud.tra_enc;
                copia_ud.copia_hog=pk_ud.tra_hog;
                copia_ud.copia_mie=pk_ud.tra_mie;
                var save_id_ud=id_ud;
                rta_ud={};
                gu.estructuraTramo.forEach(function(infoCampo){
                    rta_ud["var_"+infoCampo.nombre] = tramo[infoCampo.nombre];
                });
                id_ud=id_ud+'t'+i_tramo;
                */
                try{
                    //23/2/9 gu.estructuraTramo.forEach(function(infoCampo){
                        //23/2/9 consistir algo
                        //23/2/9 if(infoCampo.nombre!='rescate'||actividades_codigos[tramo.codigo]&& actividades_codigos[tramo.codigo].rescatable ){  
                        //23/2/9     aplicarConsistencias(estructura.formulario.UT[""], "var_"+infoCampo.nombre /*'var_codigo'*/,  //23/2/9 "var_"+infoCampo.nombre/*'var_codigo'*/, 0, 0, tramo.inputs[infoCampo.nombre]/*tramo.inputs.codigo*/);
                        //23/2/9 }   
                    //23/2/9 });   
                    recontarFilas(tablaTramos);
                    //230213 rta_ud=save_rta_ud;
                    //230213 id_ud=save_id_ud;   
                }catch(err){
                    //230213 rta_ud=save_rta_ud;
                    //230213 id_ud=save_id_ud;
                    throw err;
                }
            }
            var tr=tablaTramos.insertRow(tablaTramos.rows.length);
            tr.className="renglon_variable";
            gu.estructuraTramo.forEach(function(infoCampo){
                var nombreVar=infoCampo.nombre;
                var input = html.input({type:infoCampo.tipo, "class":"edit-"+nombreVar}).create() as unknown as TypedControl<string>;
                if(infoCampo.tabindex){
                    //input.tabIndex=-1;
                }
                TypedControls.adaptElement(input, {typeName:'text'});
                // @ts-expect-error apaga la lupa
                input.ponerLupa = ()=>{ input.lupa = input.lupa ?? html.span().create() }
                input.setTypedValue(tramo[nombreVar]||null);
                if(nombreVar == 'codigo'){
                    input.addEventListener('focus',function(){
                        pantallaAyuda.mostrar(input, i_tramo);
                    })
                    input.addEventListener('change',function(){
                        pantallaAyuda.mostrar(input, i_tramo);
                    })
                    input.addEventListener('input',function(){
                        pantallaAyuda.mostrar(input, i_tramo);
                    })
                    input.addEventListener('blur',function(){
                        pantallaAyuda.ocultar();
                    })
                }
                input.addEventListener('update',function(){
                    sessionStorage['pantalla-especial-modifico-db']=true;
                    // @ts-expect-error this dentro de un typedControl
                    var control:TypedControl<any> = this;
                    var valor=control.getTypedValue();
                    var valorCompletado = infoCampo.completador(valor);
                    if(valor !== valorCompletado){
                        setTimeout(() => control.setTypedValue(valorCompletado, true), 100);
                    }
                    var valorAnterior=tramo[nombreVar];
                    tramo[nombreVar] = valorCompletado as any;
                    validarTramo();
                    if(valorAnterior != valorCompletado && tramo.rescatable && !infoCampo.rescate){
                        tramo.rescate = '1';
                        tramo.inputs!.rescate.setTypedValue(tramo.rescate);
                    }
                    gu.acomodar();
                    gu.desplegar_izquierda('grilla-ut-zona-izquierda', corYtotal);
                    if(i_tramo===gu.tramos.length-1){
                        var nuevaPosicion = gu.tramos.push(gu.renglonVacio())-1;
                        gu.desplegarRenglon(gu.tramos[nuevaPosicion], nuevaPosicion);
                        recontarFilas(tablaTramos);
                    }
                    var elementoBotonCerrar = document.getElementById('boton-cerrar') as HTMLButtonElement
                    if(elementoBotonCerrar) elementoBotonCerrar.textContent = gu.acomodo.cargadoHasta == '24:00'?'cerrar':'cerrar incompleto';
                    grabar_todo();
                });
                tramo.inputs![nombreVar]=input;
                var celda=tr.insertCell(-1);
                celda.className="col-"+nombreVar;
                celda.appendChild(input);
            });
            tr.numeroOrdenFila=tablaTramos.childNodes.length-1;
            validarTramo();
        }
        this.tramos.forEach(this.desplegarRenglon);
        recontarFilas(tablaTramos);
        tablaTramos.parentNode!.appendChild(html.button({id:'boton-cerrar'},'cerrar...').create());
        var botonCerrar=document.getElementById('boton-cerrar');
        if(botonCerrar){
            botonCerrar.addEventListener('click',function(){
                cerrarFun();
            })
            botonCerrar.textContent = gu.acomodo.cargadoHasta=='24:00'?'cerrar':'cerrar incompleto';
        }
        this.desplegar_izquierda('grilla-ut-zona-izquierda', corYtotal);
        var ultimoTramo:TramoExtendido = gu.tramos[gu.tramos.length-1] as TramoExtendido;
        if (!ultimoTramo.desde && gu.tramos.length < 2){
            ultimoTramo.inputs.desde.setTypedValue('00:00')
            ultimoTramo.desde = '00:00';
        } 
        if (!ultimoTramo.codigo) {
            ultimoTramo.inputs.codigo.focus();
        } else if (!ultimoTramo.desde) {
            ultimoTramo.inputs.desde.focus();
        } else if (!ultimoTramo.hasta) {
            ultimoTramo.inputs.hasta.focus();
        }
        /*230213
        if(rta_ud["var_d1"] || rta_ud["var_d2"]){
            this.desplegar_rescate();
        }
        */
    }
    gu.desplegar_izquierda = function desplegar_izquierda(idDiv, corYtotal){
        var offsetSup=25;
        var offsets={
            x_hora:0,
            x_min:25,
            x_act:12,
            x_act2:90,
            x_act3:140,
            x_fin: 190,
            x_anchoActividad:57
        }
        var separarHora = function separarHora(texto:string){
            var separado = {
                hora: Number(texto.split(':')[0]),
                min: Number(texto.split(':')[1]),
                renglon: 0
            };
            separado.renglon = (separado.hora*60+separado.min)/medidas.minutosRenglon
            return separado;
        }
        var max = function<T>(a:T,b:T){return a>b?a:b; }
        var min = function<T>(a:T,b:T){return a<b?a:b; }
        var colocarCaja = function colocarCaja(tramo:TramoExtendido, nombrecaja:CorteId, desdeLimite:Hora, hastaLimite:Hora, i_columna:IdColumna, correcionX:number, correccionY:number, propiedad:string){        
            var desde=separarHora(max(min(tramo.desde as Hora,hastaLimite),desdeLimite));
            var hasta=separarHora(max(min(tramo.hasta as Hora,hastaLimite),desdeLimite));
            var cajaClassName = "caja-fija act_"+tramo.codigo
            if(!tramo[nombrecaja] || !document.body.contains(tramo[nombrecaja])){
                tramo[nombrecaja] = html.div({class:cajaClassName}).create() as HTMLDivElement & Tramo;
                tramo[nombrecaja].style.display='none';
                document.getElementById(idDiv)?.appendChild(tramo[nombrecaja]);
            }else{
                tramo[nombrecaja].className = cajaClassName
            }
            var caja = tramo[nombrecaja];
            caja.removeAttribute('style');
            if(desde.renglon<hasta.renglon){
                if(caja.desde != tramo.desde ||caja.hasta != tramo.hasta || caja.codigo != tramo.codigo){
                    if(i_columna==='agujero'){
                        //caja.textContent='agujero'
                        caja.style.left=correcionX + offsets.x_act - medidas.separacionActividad/2 + 'px'; 
                        caja.style.width=offsets.x_anchoActividad * medidas.cantAct + 'px';
                        caja.style.backgroundColor=colorAgujero;
                    }else{
                        caja.textContent=tramo.codigo;
                        caja.style.left=correcionX + offsets.x_act+(i_columna>medidas.cantAct-1?2:i_columna)*offsets.x_anchoActividad + 'px';
                        caja.style.width=offsets.x_anchoActividad - medidas.separacionActividad + 'px';
//                        var infoActividad = codigosActividad[tramo.codigo];
                        var infoActividad = actividades_codigos[tramo.codigo!];
                        if(infoActividad){
                            // caja.style.backgroundColor=infoActividad.color+'77' || colorOtros;
                            caja.appendChild(html.br().create());
                            // svgs_by_code
                            let svg = html.svg({"class": "ico-svg-actividad"}, [html.path({"d":actividades_svg[tramo.codigo!]})]).create()
                            svg.setAttribute("viewBox", "0 0 132 132");
                            caja.appendChild(svg);

                            caja.appendChild(html.br().create());
                            caja.appendChild(html.span({"class": "abr-actividad"}, infoActividad.abr).create());
                        }else{
                            caja.style.backgroundColor=colorInvalido;
                            caja.appendChild(html.br().create());
                            caja.appendChild(html.img({"src": "mini_Error.png"}).create());
                        }
                    }
                    caja.style.top=correccionY + offsetSup+desde.renglon*medidas.pixelPorRenglon + 'px';
                    caja.style.height=(hasta.renglon-desde.renglon)*medidas.pixelPorRenglon +'px';
                    if(hasta.renglon-desde.renglon>1){
                        //caja.style.fontSize='100%';
                    }
//                    caja.style.display='';
                    caja.style.display=propiedad;
                    caja.desde = tramo.desde;
                }
                caja.style.display=propiedad;
            }else{
                caja.style.display='none';
            }
        }
        this.acomodo.columnas.forEach(function(columna, i_columna){
            columna.forEach(function(tramo){
                /*if(tramo.desde && tramo.hasta){
                    cortes.forEach(function(info){
                        colocarCaja(tramo, info.id, info.desde, info.hasta, i_columna,  info.corX, info.corY+corYtotal);
                    });
                }*/
                if(!tramo.hasta || !tramo.desde){
                    var propiedad='none';
                }else{propiedad='';}
                cortes.forEach(function(info){
                    colocarCaja(tramo, info.id, info.desde, info.hasta, i_columna as IdColumna,  info.corX, info.corY+corYtotal,propiedad);
                });
            });
        });
        this.acomodo.agujeros.forEach(function(agujero){
            var propiedad='';
            cortes.forEach(function(info){
                colocarCaja(agujero as TramoExtendido, info.id, info.desde, info.hasta, 'agujero',  info.corX, info.corY+corYtotal,propiedad);
            });
        });
    };
    gu.desplegar_rescate=function(){
        var typeInfo={
            typeName:"enum",
            showOption: true,
            options:[
                {option: '1_', label: 'Sí, aunque no lo mencioné todas las veces'},
                {option: '2_', label: 'Sí, ya lo mencioné todas las veces'},
                {option: '3_', label: 'No'}
            ]
        };
        var tablaRescate=document.getElementById("tabla-rescate");
        var cartelRescate=document.getElementById('cartel-rescate');
        if(!tablaRescate){
            tablaRescate=html.table({id:"tabla-rescate"}).create();
            var filaRescate=html.tr([html.td({colspan:2},[
                tablaRescate
            ])]);
            document.getElementById('grilla-ut-tabla-externa')!.appendChild(filaRescate.create());
            var controlesRescate={};
            defPreguntasRescate.forEach(function(def){
                var typeInfo={
                    typeName:"enum",
                    showOption: true,
                    options:O_map(estructura.formulario.I1[""]["var_"+def.var].opciones, function(opcion, idOpcion){
                        return {option:idOpcion, label:opcion.texto};
                    })
                };
                var control=TypedControls.bestCtrl(typeInfo).create();
                controlesRescate[def.var]=control;
                var textoPregunta=preguntas[def.pre].pre_texto;
                TypedControls.adaptElement(control,typeInfo);
                control.addEventListener('update',function(){
                    //230213 rta_ud["var_"+def.var]=this.getTypedValue();
                    if(controlesRescate.d1.getTypedValue()==1 && controlesRescate.d2.getTypedValue() || controlesRescate.d2.getTypedValue()==1){
                        cartelRescate.textContent='Encuestador, pregunte cuándo y corrija la grilla de actividades'
                    }else{
                        cartelRescate.textContent=''
                    }
                    gu.tramos.forEach(function(tramo,i_tramo){
                        gu.habilitarRescate(tramo);
                    });
                });
                tablaRescate.appendChild(html.tr([html.td(textoPregunta), html.td([control])]).create());
                //230213 control.setTypedValue(rta_ud["var_"+def.var]);
            });
            if(!cartelRescate){
                cartelRescate=html.span({id:'cartel-rescate'}).create();
            }
//            tablaRescate.appendChild(html.tr([html.td(),html.td()]))
            var botonCerrar=document.getElementById('boton-cerrar');
            document.getElementById('tabla-rescate').appendChild(html.tr([html.td({colspan:2},[botonCerrar,cartelRescate])]).create());
            botonCerrar.addEventListener('click',function(){
                //aún no sé desde donde se llama
                cerrarFun();
            })
            
        }
        /*crearCartelRepreguntar=function(d1,d2){
            if(d2!=null && (d1='1' or d2='1')){
                var divCartelRepreguntar=html.div({id:'cartel-repreguntar'},'Repregunte')
                document.getElementById('tabla-rescate').appendChild(divCartelRepreguntar.creatr());
            }
        }*/
        
        var botonCerrar=document.getElementById('boton-cerrar');
        document.getElementById('div-rescate').appendChild(botonCerrar)
        botonCerrar.addEventListener('click',function(){
            //aún no sé desde donde se llama
            cerrarFun();
        })
        
    }
}

GrillaUt.defPreguntasRescate=defPreguntasRescate;

window.GrillaUt = GrillaUt;

window.addEventListener('keypress',function(event){
    if((event.key=='?' || event.key=='¿' || event.keyCode==63 || event.keyCode==191)  && event.target.parentNode.className=='col-codigo'){
        dialogManual().then(function(codigo){
            if(codigo && event.target.parentNode.className=='col-codigo'){
                event.target.setTypedValue(codigo);
                var updateEvent=new Event('update');
                event.target.dispatchEvent(updateEvent);
            }
        });
        event.preventDefault();
    }
})