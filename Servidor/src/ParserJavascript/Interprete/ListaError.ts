import { Error } from "./Error";

export class ListaError{

    public ListaE:Array<Error>;

    constructor(){
        this.ListaE = new Array<Error>();
    }
    public insertar(nodoN:Error):void{
        this.ListaE.push(nodoN);
    }

    public getLista():Array<Error>{
        return this.ListaE;
    }

    public reporteErrores():String{
        let c:string = "";
        c += "<tr><td>No.</td><td>Tipo Error</td><td>Linea</td><td>Columna</td><td>Descripcion</td></tr>";
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
            result +="Error "+i.tipo+", linea: "+i.linea+", columna: "+i.columna+"\n\t "+i.descripcion+"\n";
        }

        return result;
    }

    public reiniciar():void{
        this.ListaE = new Array<Error>();
    }
}