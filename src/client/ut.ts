// ver client.ts
import {html} from "js-to-html";
import { Actividades_codigos } from "../unlogged/grilla-ut";

myOwn.clientSides.verActividadSvg={
    prepare: (_depot, _fieldName)=>{},
    update: (depot, fieldName)=>{
        let td = depot.rowControls[fieldName];
        td.innerHTML='';
        if(depot.row.imagen_path){
            var svg = html.svg({
                class:"svg-actividades"
            },[
                html.path({
                    d:depot.row.imagen_path
                })
            ]).create();
            svg.setAttribute("viewBox","0 0 132 132");
            td.appendChild(svg);
        }
    }
};
myOwn.clientSides.actividadesRow={
    prepare: (_depot)=>{},
    update: (depot)=>{
        let rowc = depot.rowControls;
        if(depot.row.color){
            rowc['color'].style.backgroundColor=depot.row.color;
        };    
    }
};

myOwn.wScreens.generar_manual=async function(){
    var mainLayout = document.getElementById('main_layout')!;
    var manual=html.div({id:'manual'}).create();
    mainLayout.appendChild(manual);
    var titulo=html.p({class:"destacado"},'Clasificador de Actividades').create();
    //titulo.textContent='Clasificador de Actividades';
    var tabla=html.table({id:'prettyTable'}).create()
    var rActividades=await myOwn.ajax.traer_actividades()
    var columnas=['codigo','detalle','imagen'];
    var tabla_thead=html.tr(columnas.map(cl=>{return html.th(cl)})).create();
   
    var act_tbody=html.tbody(rActividades.map((actividad:Actividades_codigos)=>{
        var colorCod = actividad.color;
        var borderColor = "border-color:"+ colorCod ;
            return(
            html.tr([
                html.td({class:"span codigo_act", style:"background-color:"+colorCod+';'+borderColor }, actividad.codigo),
                html.td({class:"detalle", style:borderColor}, [html.span({class:"destacado"}, actividad.texto),
                    html.p(actividad.detalle),
                ]), html.td({style:borderColor},[html.svg({class:"svg-actividades", viewbox:"0 0 132 132"},
                        [html.path({d:actividad.imagen_path})]
                )])
            ])
        )
    })).create();

    tabla.appendChild(tabla_thead);
    tabla.appendChild(act_tbody);
    
    manual.appendChild(html.p().create());
    manual.appendChild(titulo);
    manual.appendChild(tabla);


}; 
