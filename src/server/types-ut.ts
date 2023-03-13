import * as dmencu from "dmencu";

export * from "dmencu";

declare module "dmencu"{
    interface WScreens {
        demo: {}
        abrir_encuesta: {}
        sincronizar_dm: {}
    }
    interface TableContext{
        puede:{
            encuestas:{
                justificar:boolean
            }
        }
    }
}

/*
export declare type MenuDefinition = {
    menu: MenuInfo[];
};*/