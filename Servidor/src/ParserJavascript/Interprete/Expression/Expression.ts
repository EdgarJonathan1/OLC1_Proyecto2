import { Retorno } from "./Retorno";

export abstract class Expression {

    public line: number=0;
    public column: number=0;

    constructor(line: number, column: number) {
        this.line = line;
        this.column = column;
    }

    public abstract translate() : Retorno;
    public abstract ast():void;
}