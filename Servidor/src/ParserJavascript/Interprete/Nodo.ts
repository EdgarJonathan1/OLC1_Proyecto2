import {spawn} from 'child_process'

export class Nodo {

    public id:number = 0;
    public hijos:Nodo[]=[];

    constructor(
        public valor:string,
        public tipo:string,
    ){
    
    } 

    execdot(){
                spawn('dot', ['-Tpdf', '-o', './AST.pdf','codigo.dot']);
    }
  
    getValor(){
      return  this.valor;
    }

    getTipo(){
        return this.getTipo;
    }

    add(node:Nodo){
        this.hijos.push(node);
    }

}