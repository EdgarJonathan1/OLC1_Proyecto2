import  {Expression}  from '../Expression/Expression'
import { Retorno,Type } from '../Expression/Retorno';


export class If extends Expression{
    
    constructor(
        private condicion:Expression,
        private body:Expression[],
        private elseif:Expression[],
        line:number,
        column:number
    ){
        super(line,column);
    } 
    
    public translate(): Retorno {
    
       var  result = 'if('+this.condicion.translate().value+'){\n\t';
        
       for (var statment of this.body) {
          result+= statment.translate().value; 
       }

       result += '\n\t}';
     
       this.elseif.forEach(element => {
          result+= element.translate().value; 
       });

       let retorno:Retorno = {value:result,type: Type.STRING}
       return retorno;
    }
    public ast(): void {
        throw new Error('Method not implemented.');
    }

}