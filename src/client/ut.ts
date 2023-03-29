// ver client.ts
import {html} from "js-to-html";

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
