import {ID,TokenName} from './Constantes';
import {Token} from './Token';
import {ListaToken} from '../../Interprete/ListaToken';
import {Error} from '../../Interprete/Error';
import {ListaError} from '../../Interprete/ListaError';

export class Lexico {

    private estado: number = 0;
    private linea: number = 1;
    private columna: number = 0;
    private lexemaActual: string = "";

    private Simbolo: Array<string>;
    public tokens:ListaToken; 
    public errores:ListaError;



    constructor() {
        this.tokens = new ListaToken();
        this.errores = new ListaError();
        this.Simbolo = new Array<string>();

    }

    llenarSimbolo(){
        this.Simbolo.push(";");
        this.Simbolo.push("{");
        this.Simbolo.push("}");
        this.Simbolo.push("(");
        this.Simbolo.push(")");
        this.Simbolo.push("+");
        this.Simbolo.push("-");
        this.Simbolo.push("*");
        this.Simbolo.push("/");
        this.Simbolo.push("<");
        this.Simbolo.push(">");
        this.Simbolo.push("=");
        this.Simbolo.push("^");
        this.Simbolo.push("!");
        this.Simbolo.push("&");
        this.Simbolo.push("|");
    }


    vaciar() {

        this.estado = 0;
        this.linea = 1;
        this.columna = 0;
        this.lexemaActual = "";

        this.tokens = new ListaToken();
        this.errores = new ListaError();
    }

    analizar(texto: string) {
        this.vaciar();
        this.llenarSimbolo();
        //texto = texto.replace("\t", "    ");//Ponemos espacios para contar la columna        
        texto = texto.toLocaleLowerCase();

            console.log(this.Simbolo);
        let i: number = 0;
        while (i < texto.length) {
            let letter = texto.charAt(i);
            if (letter == "\n") {
                this.linea += 1;
                this.columna = 0;
            }
            
            //Iniciando Automata
            switch (this.estado) {
                case 0:
                    i = this.S0(i, texto);
                    break;
                case 1:
                    i = this.S1(i, texto);//Estado de Aceptacion
                    break;
                case 2:
                    i = this.S2(i, texto);//Aceptacion
                    break;
                case 3:
                    i = this.S3(i, texto);
                    break;
                case 4:
                    i = this.S4(i, texto);//Aceptacion
                    break;
                case 5:
                    i = this.S5(i, texto);
                    break;
                case 6:
                    i = this.S6(i, texto);
                    break;
                case 7:
                    i = this.S7(i, texto);
                    break;
                case 8:
                    console.log('porque no llegamos?');
                    i = this.S8(i, texto);//Aceptacion
                    break;
                case 9:
                    i = this.S9(i, texto);
                    break;
                case 10:
                    i = this.S10(i, texto);
                    break;
                case 11:
                    i = this.S11(i, texto);//Aceptacion
                    break;
                case 12:
                    i = this.S12(i, texto);
                    break;
                case 13:
                    i = this.S13(i, texto);//Aceptacion
                    break;
                case 14:
                    i = this.S14(i, texto);
                    break;
                case 15:
                    i = this.S15(i, texto);//Aceptacion
                    break;
                case 16:
                    i = this.S16(i, texto);
                    break;
                case 17:
                    i = this.S17(i, texto);
                    break;
                case 18:
                    i = this.S18(i, texto);
                    break;
                case 19:
                    i = this.S19(i, texto);
                    break;
                case 20:
                    i = this.S20(i, texto);
                    break;
                case 21:
                    i = this.S21(i, texto);
                    break;
                case 22:
                    i = this.S22(i, texto);
                    break;
            }

            //Fin del while aumentamos i
            i += 1; this.columna += 1;
        }

    }

    S0(i: number, texto: string): number {

        let letter: string = texto[i];

        console.log('[',texto[i],']',this.Simbolo.includes(letter));

        if (this.isalpha(letter)) {
            this.nexState(letter,1);
        }
        else if(this.isNumber(letter)){
            this.nexState(letter,2);
        }
        else if(letter=="/"){
            this.nexState(letter,5);
        }
        else if(letter=="\""){
            this.nexState(letter,10);
        }
        else if(letter=="'"){
            this.nexState(letter,12);
        }
        else if(this.Simbolo.includes(letter)){
            this.nexState(letter,9);
        }
        else{
            this.err(i,texto);
        }

        return i;
    }
    S1(i: number, texto: string): number {
   
        let letter: string = texto.charAt(i);
        if(this.isalpha(letter) || this.isNumber(letter)||letter=="_"){
            this.nexState(letter,1);
        }
        // else if(letter=="["){
        //     this.nexState(letter,21);
        // }
        // else if(letter=="."){
        //     this.nexState(letter,17);
        // }
        else {
             i = this.accept(i,TokenName[ID.eid],ID.eid);
        }

        return i; 
    }
    S2(i: number, texto: string): number {
   
        let letter: string = texto.charAt(i);
        if(this.isalpha(letter)){
            this.nexState(letter,2);
        }
        else if(letter == "."){
            this.nexState(letter,3);
        }
        else {
            i=this.accept(i,TokenName[ID.eint],ID.eint)
        }
        
       return i; 
    }
    S3(i: number, texto: string): number { 

        let letter: string = texto.charAt(i);
        if(this.isNumber(letter)){
            this.nexState(letter,4);
        }
        else {
            this.err(i,texto);
        }
        return i; 
    }
    S4(i: number, texto: string): number {
       
        let letter: string = texto.charAt(i);
        if(this.isNumber(letter)){
            this.nexState(letter,4);
        }
        else {
             i = this.accept(i,TokenName[ID.edouble],ID.edouble);
        }
       
        return i; 
    }
    S5(i: number, texto: string):number { 
        let letter: string = texto.charAt(i);

        if(letter=="/"){
            this.nexState(letter,14);
        }
        else if(letter=="*"){
            this.nexState(letter,6);
        }
        else {
            this.err(i,texto);
        }
        return i;
    }
    S6(i: number, texto: string):number {
    
        let letter: string = texto.charAt(i);
        if(letter!="*"){
            this.nexState(letter,6);
        }
        else {
            this.nexState(letter,7);
        }
    
        return i; 
    }
    S7(i: number, texto: string): number {
        
        let letter: string = texto.charAt(i);
        if(letter=="*"){
            this.nexState(letter,7);
        }
        else if(letter=="/"){
            this.nexState(letter,8);
        }
        else {
            this.nexState(letter,6);
        }
        return i; 
    }
    S8(i: number, texto: string): number { 
        return this.accept(i,TokenName[ID.ecomentario],ID.ecomentario);
    }
    S9(i: number, texto: string): number { 

        let letter: string = texto.charAt(i);
        let idSimbol:number = this.getIdSimbolToken(letter);
        if(idSimbol!=-1){
            i=this.accept(i,TokenName[idSimbol],idSimbol);
        }else if(idSimbol==-1){//debe ser un | o un &
            this.nexState(letter,16);
        }else{
            this.err(i,texto);
        }
        return i; 
    }
    S10(i: number, texto: string): number { 

        let letter: string = texto.charAt(i);
        if(letter!="\""){
            this.nexState(letter,10);
        }
        else {
            this.nexState(letter,11);
        }
        return i; 
    }
    S11(i: number, texto: string): number {
        return this.accept(i,TokenName[ID.estring],ID.estring);
    }
    S12(i: number, texto: string): number { 
        
        let letter: string = texto.charAt(i);
        if(letter!="'"){
            this.nexState(letter,10);
        }
        else {
            this.nexState(letter,11);
        }
        return i; 
    }
    S13(i: number, texto: string): number { 

        if(this.lexemaActual.length==1){
            i = this.accept(i,TokenName[ID.echar],ID.echar);
        }else {
            i = this.accept(i,TokenName[ID.estring],ID.estring);
        }
        return i; 
    }
    S14(i: number, texto: string): number { 
        
        let letter: string = texto.charAt(i);
        if(letter!="\n"){
            this.nexState(letter,14);
        }
        else {
            this.nexState(letter,15);                
        }
        return i; 
    }
    S15(i: number, texto: string): number { 
        return this.accept(i,TokenName[ID.ecomentarioSimple],ID.ecomentarioSimple);
    }
    S16(i: number, texto: string): number { 

        let letter: string = texto.charAt(i);

        if(letter=="|"){
            i=this.accept(i,TokenName[ID.sor],ID.sor);
        }
        else if(letter=="&"){
            i=this.accept(i,TokenName[ID.sand],ID.sand);
        }else {
            this.err(i,texto);
        }

        return i; 
    }
    S17(i: number, texto: string): number { return i; }
    S18(i: number, texto: string): number { return i; }
    S19(i: number, texto: string): number { return i; }
    S20(i: number, texto: string): number { return i; }
    S21(i: number, texto: string): number { return i; }
    S22(i: number, texto: string): number { return i; }

    //***************************************************************************************************************** 
    //***********************************Metodos de Ayuda************************************************************** 
    //***************************************************************************************************************** 
    getIdSimbolToken(letter:string):number{

        let result:number = -1;

        if(letter==";"){
            result = ID.spyc;
        }
        else if(letter=="{"){
            result = ID.sllaveizq;
        }
        else if(letter=="}"){
            result = ID.sllaveder;
        }
        else if(letter=="("){
            result = ID.sparizq;
        }
        else if(letter==")"){
            result = ID.sparder;
        }
        else if(letter=="+"){
            result = ID.smas;
        }
        else if(letter=="-"){
            result = ID.smenos;
        }
        else if(letter=="*"){
            result = ID.spor;
        }
        else if(letter=="/"){
            result = ID.sdiv;
        }
        else if(letter=="<"){
            result = ID.smenorque;
        }
        else if(letter==">"){
            result = ID.smayorque;
        }
        else if(letter=="="){
            result = ID.sigual;
        }
        else if(letter=="^"){
            result = ID.sxor;
        }
        else if(letter=="!"){
            result = ID.snot;
        }
        
        return result;
    }

    isalpha(str: string) {
        return str.length === 1 && str.match(/[a-z]/i);
    }

    isNumber(str: string) {
        return str.length === 1 && str.match(/[0-9]/i);
    }

    accept(i: number, tokenName: string,id:number):number{

        this.lexemaActual = this.lexemaActual.replace("\n", "");

        let linea: string = this.linea.toString();
        let columna: string = this.columna.toString();
        let tipo: string = tokenName//Falta una forma de identificarlo
        let descripcion: string = this.lexemaActual; 

        let token: Token = new Token(linea, columna, tipo, descripcion, id);
        this.tokens.push(token);

         //console.log('Se reconocio el token: ',tokenName); 

        this.lexemaActual ="";
        this.estado =0;
        i-=1;
        this.columna-=1;

        return i;
    }

    nexState(letter:string, state:number) {
        this.lexemaActual += letter;
        this.estado = state;
    }

    err(i: number, texto: string) {

        let letter: string = texto.charAt(i);
        this.lexemaActual += letter;
        if (letter != " " && letter != "\n" && letter != "\t") {

            for (let i = 0; i < this.lexemaActual.length; i++) {
                const caracter = this.lexemaActual.charAt(i);

                let tipo: string = "Lexico";
                let linea: string = this.linea.toString();
                let columna: string = this.columna.toString();
                let Descripcion: string = "El caracter" + caracter + " no pertenece al lenguaje";
                let err: Error = new Error(tipo, linea, columna, Descripcion);
                this.errores.push(err);

            }

            this.estado = 0;
            this.lexemaActual = "";
        }
    }

}