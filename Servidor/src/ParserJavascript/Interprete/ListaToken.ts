import { Token } from "./Token";

export class ListaToken{

    public ListaE:Array<Token>;

    constructor(){
        this.ListaE = new Array<Token>();
    }
    public insertar(nodoN:Token):void{
        this.ListaE.push(nodoN);
    }

    public getLista():Array<Token>{
        return this.ListaE;
    }

    public reporteTokens():String{
        let c:string = "";
        c += "<tr><td>No.</td><td>Tipo Token</td><td>Fila</td><td>Columna</td><td>Descripcion</td></tr>";
        let n:number = 1;
        for(let i of this.ListaE){
            c += "<tr><td>"+n+"</td><td>"+i.tipo+"</td><td>"+ i.linea +"</td><td>"+i.columna+"</td><td>"+i.descripcion+"</td></tr>\n";
            n++;
        }
        return c;
    }

    public reportConsola():String
    {
        let result :String = "";

        for(let i of this.ListaE)
        {
            result +="Token "+i.tipo+", linea: "+i.linea+", columna: "+i.columna+"\n\t "+i.descripcion+"\n";
        }

        return result;
    }

    public reiniciar():void{
        this.ListaE = new Array<Token>();
    }
}