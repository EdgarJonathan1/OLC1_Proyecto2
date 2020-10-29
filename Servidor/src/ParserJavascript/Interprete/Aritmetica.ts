import { Expression } from "./Expression";
import { Retorno } from "./Retorno";

export class Aritmetica extends Expression{

    constructor(
        private left: Expression,
        private right: Expression,
        private type:  String ,
        line: number,
        column: number
    ) {
        super(line, column);
    }

    public translate(): Retorno {
        throw new Error("Method not implemented.");
        //codigo traducido
    }
    public ast( ): void {
       console.log(this.left,this.right,this.type); 

       //codigo grapvhiz
    }

}