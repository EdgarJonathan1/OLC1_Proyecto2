import { Expression } from ".././Expression/Expression";
import { Retorno,Type} from "../Expression/Retorno";

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

        let resultLeft:string= <string>this.left.translate().value();
        let resultRight:string = <string>this.right.translate().value();

        let result = resultLeft+'+'+resultRight;

        let retorno:Retorno = {value:result,type: Type.STRING}
        
        return retorno;
    }
    public ast( ): void {
       console.log(this.left,this.right,this.type); 

       //codigo grapvhiz
    }

}