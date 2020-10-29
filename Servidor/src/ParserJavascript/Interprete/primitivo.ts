import { Expression } from "./Expression";
import { Retorno } from "./Retorno";

class Primitivo implements Expression{



    public line: number = 0;
    public column: number = 0;

    valor:string;
    tipo:string;
    fila:number;
    columna:number;



    constructor(tipo:string, valor:string, fl:number , cl:number){
        this.tipo = tipo;
        this.valor = valor;
        this.fila = fl;
        this.columna = cl;
       // console.log("Primitivo ");
    }
       public translate(): Retorno {
        throw new Error("Method not implemented.");
    }
    public ast(): void {
        throw new Error("Method not implemented.");
    }
}

export{Primitivo}