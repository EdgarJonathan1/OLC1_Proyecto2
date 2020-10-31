/* Analizador de proyecto 2 */

%{
    var AST = require("../AST/Entornos/AST");
    var Lista = require("../AST/Entornos/Lista");

    var Primitivo = require("../AST/Expresion/Primitivo");
    var Operacion = require("../AST/Expresion/Operacion");
    var Unario = require("../AST/Expresion/Unario");

    var Asignacion = require("../AST/Instruccion/Asignacion");
    var Declaracion = require("../AST/Instruccion/Declaracion");
    var Imprimir = require("../AST/Instruccion/Imprimir");
    var Tipo = require("../AST/Instruccion/Tipo");

    var Switch = require("../AST/Instruccion/Switch");
    var Case = require("../AST/Instruccion/Case");
    var While = require("../AST/Instruccion/While");
    var For = require("../AST/Instruccion/For");
    var If = require("../AST/Instruccion/If");
    var ElseIf = require("../AST/Instruccion/ElseIf");

    var Transferencia = require("../AST/Instruccion/Transferencia");

    var Funcion = require("../AST/Instruccion/Funcion");
    var Llamada = require("../AST/Instruccion/Llamada");

    var SentenciaClass = require("../AST/Instruccion/SentenciaClass");

    var Import = require("../AST/Instruccion/Import");

    var ListaErrores = require("../AST/Entornos/ListaErrores");
    var NodoError = require("../AST/Entornos/NodoError");
    global.LError = new ListaErrores.ListaErrores();
%}

/* lexical grammar */
%lex

%%


  
("/*"(.|[\r\n])*?"*/")    /*comentario multilinea*/
("//".*\r\n)|("//".*\n)|("//".*\r)          /*comentario unilinea*/  

//Relacionales
"<="                return 'tk_<=';
">="                return 'tk_>=';
"<"                 return 'tk_<';
">"                 return 'tk_>';
"=="                return 'tk_==';
"!="                return 'tk_!=';

//Aritmeticos
"^"                 return 'tk_^';
"%"                 return 'tk_%';
"*"                 return 'tk_*';
"/"                 return 'tk_/';
"--"                 return 'tk_--';
"++"                 return 'tk_++';
"-"                 return 'tk_-';
"+"                 return 'tk_+';
"("                 return 'tk_(';
")"                 return 'tk_)';

//Simbolos
"{"                 return 'tk_{';
"}"                 return 'tk_}';
"="                 return 'tk_=';
";"                 return 'tk_;';
","                 return 'tk_,';
":"                 return 'tk_:';
"."                 return 'tk_.';

//Logicos
"&&"                return 'tk_&&';
"||"                return 'tk_||';
"!"                 return 'tk_!';

//Palabras reservadas
"int"               return 'tkInt';
"double"            return 'tkDouble';
"String"            return 'tkString';
"boolean"           return 'tkBoolean';
"char"              return 'tkChar';
"class"             return 'tkClass';
"import"            return 'tkImport';
"true"              return 'Boolean';
"false"             return 'Boolean';
"if"                return 'tkIf';
"else"              return 'tkElse';
"switch"            return 'tkSwitch';
"case"              return 'tkCase';
"default"           return 'tkDefault';
"break"             return 'tkBreak';
"while"             return 'tkWhile';
"do"                return 'tkDo';
"System"            return 'tkSystem';
"out"               return 'tkOut';
"print"             return 'tkPrint';
"println"           return 'tkPrintln';
"for"               return 'tkFor';
"continue"          return 'tkContinue';
"return"            return 'tkReturn';
"void"              return 'tkVoid';
/*"main"              return 'tkMain';*/

//ER
\s+                                         /*ignora ' '*/
[0-9]+"."[0-9]*                             return 'Double';
[0-9]+\b                                    return 'Int';
[\"]([^\"\n]|(\\\"))*[\"]                   return 'Cadena';            //arreglar
[\'][^\'\n][\']                             return 'Char';
["_"A-Za-z]+["_"0-9A-Za-z]*                 return 'Id';

<<EOF>>             return 'EOF';

.   {LError.insertar(new NodoError.NodoError("Lexico", yylloc.first_line, yylloc.first_column, "El caracter '"+ yytext+"' no pertenece al lenguaje.")); console.log(".-.-.-");}

/lex

/* precedencia */

%left 'tk_||'
%left 'tk_&&'

%left 'tk_!=' 'tk_=='
%left 'tk_<' 'tk_>' 'tk_<=' 'tk_>='

%left 'tk_+' 'tk_-'
%left 'tk_*' 'tk_/' 'tk_%'
%left 'tk_^' 

%right '!'
%right UNM

%left 'tk_--' 'tk_++'

%start S

%%  /*gramatica*/

S: SInicio EOF {}
;

Sentencias  : Sentencias Sentencia {}     /*inserta lista en la lista que devuelve Sentencia*/
            | Sentencia {}         /*crea lista e inserta nodo*/
;

Sentencia   : SImprimir {}
            | Asignacion {}
            | Declaracion {}
            | SWhile {}
            | SDo {}
            | SSwitch {}
            | SFor {}
            | SIf {}
            | STransferencia {}  /* conflicto por break se puede hacer sentencias diferentes para case*/

            | SLlamada {}
            | SFuncion {}

        /*    | SImport {$$ = $1;}
            | SClass {$$ = $1;}*/
            | error { LError.insertar(new NodoError.NodoError("Sintactico", this._$.first_line, this._$.first_column, "No se esperaba " + yytext)); }

;

/*Inicio  : ListaImport ListaClass {$$ = new Lista.Lista(); $$.insertar($1.getLista()); $$.insertar($2.getLista()); }       
        | ListaClass {$$ = new Lista.Lista(); $$.insertar($1.getLista()); } 
;*/

SInicio : SInicio Inicio {$$ = $1; $$.insertar($2); }     /*inserta lista en la lista que devuelve Sentencia*/
        | Inicio {$$ = new Lista.Lista(); $$.insertar($1); }         /*crea lista e inserta nodo*/
;

Inicio : SImport {$$ = $1;}
        | SClass {$$ = $1;}
        | error { LError.insertar(new NodoError.NodoError("Sintactico", this._$.first_line, this._$.first_column, "No se esperaba " + yytext)); }
;

ListaClass : ListaClass SClass
                {$$ = $1; $$.insertar($2); console.log("lista class");}
            | SClass
                {$$ = new Lista.Lista(); $$.insertar($1); console.log("un class")}
; 

SClass  : 'tkClass' Id 'tk_{' Sentencias 'tk_}'
            {$$ = new SentenciaClass.SentenciaClass($2, $4.getLista(), @1.first_line, @1.first_column); console.log("class"); }
        | 'tkClass' Id 'tk_{' 'tk_}'
            {$$ = new SentenciaClass.SentenciaClass($2, null, @1.first_line, @1.first_column); console.log("class"); }
;

CuerpoClase : CuerpoClase Cuerpo {$$ = $1; $$.insertar($2); }     /*inserta lista en la lista que devuelve Sentencia*/
            | Cuerpo {$$ = new Lista.Lista(); $$.insertar($1); }         /*crea lista e inserta nodo*/
;

Cuerpo  : Declaracion { $$ = $1; }
        | SFuncion { $$ = $1; }
;

ListaImport : ListaImport SImport
                {$$ = $1; $$.insertar($2); console.log("lista import");}
            | SImport
                {$$ = new Lista.Lista(); $$.insertar($1); console.log("un import")}
; 

SImport : 'tkImport' Id 'tk_;'
            {$$ = new Import.Import($2); console.log("import"); }
;

SImprimir   : 'tkSystem' 'tk_.' 'tkOut' 'tk_.' 'tkPrint' 'tk_(' E 'tk_)' 'tk_;' 
                    {$$ = new Imprimir.Imprimir($7, @1.first_line, @1.first_column); }
            | 'tkSystem' 'tk_.' 'tkOut' 'tk_.' 'tkPrintln' 'tk_(' E 'tk_)' 'tk_;' 
                    {$$ = new Imprimir.Imprimir($7, @1.first_line, @1.first_column); }
;


TipoDato    : 'tkInt'
                {$$ = "Integer"; }
    	    | 'tkDouble'
                {$$ = "Double"; }
	        | 'tkChar'
                {$$ = "Char"; }
	        | 'tkBoolean'
                {$$ = "Boolean"; }
	        | 'tkString'
                {$$ = "String"; }
;

Asignacion  : Id 'tk_=' E 'tk_;'
                {$$ = new Asignacion.Asignacion($1, $3, null, @1.first_line, @1.first_column); }
            | Id 'tk_=' SLlamada
                {$$ = new Asignacion.Asignacion($1, null, $3, @1.first_line, @1.first_column); }
;

Declaracion : TipoDato ListaID 'tk_=' E 'tk_;'
                {$$ = new Declaracion.Declaracion($1, $2.getLista(), @1.first_line, @1.first_column, $4, null); }
            | TipoDato ListaID 'tk_;'
                {$$ = new Declaracion.Declaracion($1, $2.getLista(), @1.first_line, @1.first_column, null, null); } 
            | TipoDato ListaID 'tk_=' SLlamada
                {$$ = new Declaracion.Declaracion($1, $2.getLista(), @1.first_line, @1.first_column, null, $4); }    
;

ListaID : ListaID 'tk_,' LID
            {$$ = $1; $$.insertar($3); console.log("lista id");}
        | LID
            {$$ = new Lista.Lista(); $$.insertar($1); console.log("un id")}
;

LID  : Id       
        {$$ = new Primitivo.Primitivo("Id", $1, @1.first_line, @1.first_column); console.log("id");}
;

SWhile  : 'tkWhile' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new While.While(false, $3, $6.getLista(), @1.first_line, @1.first_column); console.log("while"); }
        | 'tkWhile' 'tk_(' E 'tk_)' 'tk_{' 'tk_}'
            {$$ = new While.While(false, $3, null, @1.first_line, @1.first_column); console.log("while"); }
;

SDo     : 'tkDo' 'tk_{' Sentencias 'tk_}' 'tkWhile' 'tk_(' E 'tk_)' 'tk_;'
            {$$ = new While.While(true, $7, $3.getLista(), @1.first_line, @1.first_column); console.log("do while"); }
        | 'tkDo' 'tk_{' 'tk_}' 'tkWhile' 'tk_(' E 'tk_)' 'tk_;'
            {$$ = new While.While(true, $6, null, @1.first_line, @1.first_column); console.log("do while"); }
;

SFor    : 'tkFor' 'tk_(' Declaracion E 'tk_;' E 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new For.For($3, null, $4, $6, $9.getLista(), @1.first_line, @1.first_column); console.log("for declaracion "); }
        | 'tkFor' 'tk_(' Declaracion E 'tk_;' E 'tk_)' 'tk_{' 'tk_}'
            {$$ = new For.For($3, null, $4, $6, null, @1.first_line, @1.first_column); console.log("for declaracion sin sentencias"); }
        | 'tkFor' 'tk_(' Asignacion E 'tk_;' E 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new For.For(null, $3, $4, $6, $9.getLista(), @1.first_line, @1.first_column); console.log("for asignacion "); }
        | 'tkFor' 'tk_(' Asignacion E 'tk_;' E 'tk_)' 'tk_{' 'tk_}'
            {$$ = new For.For(null, $3, $4, $6, null, @1.first_line, @1.first_column); console.log("for asignacion sin sentencias"); }    
;

SSwitch : 'tkSwitch' 'tk_(' E 'tk_)' 'tk_{' SCases 'tk_}'   /*falta default sin sentencias*/
            {$$ = new Switch.Switch($3, $6.getLista(), false, null, false, @1.first_line, @1.first_column); console.log("switch");}
        | 'tkSwitch' 'tk_(' E 'tk_)' 'tk_{'  'tk_}'   /*falta default*/
            {$$ = new Switch.Switch($3, null, false, null, false, @1.first_line, @1.first_column); console.log("switch");}
        | 'tkSwitch' 'tk_(' E 'tk_)' 'tk_{' SCases 'tkDefault' 'tk_:' Instrucciones 'tk_}'   /*con default con Sentencias*/
            {$$ = new Switch.Switch($3, $6.getLista(), true, $9.getLista(), false, @1.first_line, @1.first_column); console.log("switch");}
        | 'tkSwitch' 'tk_(' E 'tk_)' 'tk_{' 'tkDefault' 'tk_:' Instrucciones 'tk_}'   /*con default con Sentencias*/
            {$$ = new Switch.Switch($3, null, true, $8.getLista(), false, @1.first_line, @1.first_column); console.log("switch");}
        | 'tkSwitch' 'tk_(' E 'tk_)' 'tk_{' SCases 'tkDefault' 'tk_:' Instrucciones 'tkBreak' 'tk_;' 'tk_}'   /*con default con Sentencias*/
            {$$ = new Switch.Switch($3, $6.getLista(), true, $9.getLista(), true, @1.first_line, @1.first_column); console.log("switch");}
        | 'tkSwitch' 'tk_(' E 'tk_)' 'tk_{' 'tkDefault' 'tk_:' Instrucciones 'tkBreak' 'tk_;' 'tk_}'   /*con default con Sentencias*/
            {$$ = new Switch.Switch($3, null, true, $8.getLista(), true, @1.first_line, @1.first_column); console.log("switch");}
;

SCases  : SCases SCase {$$ = $1; $$.insertar($2); console.log("cases"); }     /*inserta lista en la lista que devuelve */
        | SCase {$$ = new Lista.Lista(); $$.insertar($1); }         /*crea lista e inserta nodo*/
;

SCase   : /*'tkCase' E 'tk_:' Sentencias 'tkBreak' 'tk_;' SCase
            {console.log("case!"); }
        | 'tkCase' E 'tk_:' Sentencias SCase
            {console.log("case"); }
        | 'tkCase' E 'tk_:'  'tkBreak' 'tk_;' SCase
            {console.log("case!"); }
        | 'tkCase' E 'tk_:'  SCase
            {console.log("case"); }
        |*/ 'tkCase' E 'tk_:' Instrucciones 'tkBreak' 'tk_;' 
            {$$ = new Case.Case($2, $4.getLista(), true, @1.first_line, @1.first_column); console.log("case!"); }
        | 'tkCase' E 'tk_:' Instrucciones 
            {$$ = new Case.Case($2, $4.getLista(), false, @1.first_line, @1.first_column); console.log("case"); }
        | 'tkCase' E 'tk_:'  'tkBreak' 'tk_;' 
            {$$ = new Case.Case($2, null, true, @1.first_line, @1.first_column); console.log("case!"); }
        | 'tkCase' E 'tk_:'  
            {$$ = new Case.Case($2, null, false, @1.first_line, @1.first_column); console.log("case"); }
;

Instrucciones  : Instrucciones Instruccion {$$ = $1; $$.insertar($2); }     /*inserta lista en la lista que devuelve Sentencia*/
            | Instruccion {$$ = new Lista.Lista(); $$.insertar($1); }         /*crea lista e inserta nodo*/
;

Instruccion : SImprimir { $$ = $1; }
            | Asignacion { $$ = $1; }
            | Declaracion { $$ = $1; }
            | SWhile {$$ = $1; }
            | SDo {$$ = $1; }
            | SSwitch {$$ = $1; }
            | SFor {$$ = $1; }
            | SIf {$$ = $1; }
            | SLlamada {$$ = $1; }
            | error { LError.insertar(new NodoError.NodoError("Sintactico", this._$.first_line, this._$.first_column, "No se esperaba " + yytext)); }

;

SIf : 'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' ListaElseif
        {$$ = new If.If($3, $6.getLista(), $8.getLista(), false, null); console.log("if else if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' 
        {$$ = new If.If($3, $6.getLista(), null, false, null); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' ListaElseif
        {$$ = new If.If($3, null, $7.getLista(), false, null); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' 
        {$$ = new If.If($3, null, null, false, null); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' ListaElseif 'tkElse' 'tk_{' Sentencias 'tk_}'
        {$$ = new If.If($3, $6.getLista(), $8.getLista(), true, $11.getLista()); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' 'tkElse' 'tk_{' Sentencias 'tk_}'
        {$$ = new If.If($3, $6.getLista(), null, true, $10.getLista()); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' ListaElseif 'tkElse' 'tk_{' Sentencias 'tk_}'
        {$$ = new If.If($3, null, $7.getLista(), true, $10.getLista()); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' 'tkElse' 'tk_{' Sentencias 'tk_}'
        {$$ = new If.If($3, null, null, true, $9.getLista()); console.log("if"); }
    |'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' ListaElseif 'tkElse' 'tk_{' 'tk_}'
        {$$ = new If.If($3, $6.getLista(), $8.getLista(), true, null);console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' 'tkElse' 'tk_{' 'tk_}'
        {$$ = new If.If($3, $6.getLista(), null, true, null); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' ListaElseif 'tkElse' 'tk_{' 'tk_}'
        {$$ = new If.If($3, null, $7.getLista(), true, null); console.log("if"); }
    | 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' 'tkElse' 'tk_{' 'tk_}'
        {$$ = new If.If($3, null, null, true, null); console.log("if"); }
;

ListaElseif : ListaElseif SElseif
                {$$ = $1; $$.insertar($2); console.log("else if");}
            | SElseif
                {$$ = new Lista.Lista(); $$.insertar($1); console.log("un else if")}
;

SElseif : 'tkElse' 'tkIf' 'tk_(' E 'tk_)' 'tk_{' Sentencias 'tk_}' 
            {$$ = new ElseIf.ElseIf($4, $7.getLista()); console.log("else if"); }  
        | 'tkElse' 'tkIf' 'tk_(' E 'tk_)' 'tk_{' 'tk_}' 
            {$$ = new ElseIf.ElseIf($4, null); console.log("else if sin sentencias"); }  
;

SFuncion : 'tkVoid' Id 'tk_(' ListaParametros 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new Funcion.Funcion("Void", $2, $4.getLista(), $7.getLista(), @1.first_line, @1.first_column); console.log("void"); }
        | TipoDato Id 'tk_(' ListaParametros 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new Funcion.Funcion($1, $2, $4.getLista(), $7.getLista(), @1.first_line, @1.first_column);console.log("funcion"); }
        | 'tkVoid' Id 'tk_(' ListaParametros 'tk_)' 'tk_{' 'tk_}'
            {$$ = new Funcion.Funcion("Void", $2, $4.getLista(), null, @1.first_line, @1.first_column); console.log("void"); }
        | TipoDato Id 'tk_(' ListaParametros 'tk_)' 'tk_{' 'tk_}'
            {$$ = new Funcion.Funcion($1, $2, $4.getLista(), null, @1.first_line, @1.first_column); console.log("funcion"); }
        | 'tkVoid' Id 'tk_(' 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new Funcion.Funcion("Void", $2, null, $6.getLista(), @1.first_line, @1.first_column); console.log("void"); }
        | TipoDato Id 'tk_(' 'tk_)' 'tk_{' Sentencias 'tk_}'
            {$$ = new Funcion.Funcion($1, $2, null, $6.getLista(), @1.first_line, @1.first_column); console.log("funcion"); }
        | 'tkVoid' Id 'tk_(' 'tk_)' 'tk_{' 'tk_}'
            {$$ = new Funcion.Funcion("Void", $2, null, null, @1.first_line, @1.first_column); console.log("void"); }
        | TipoDato Id 'tk_(' 'tk_)' 'tk_{' 'tk_}'
            {$$ = new Funcion.Funcion($1, $2, null, null, @1.first_line, @1.first_column); console.log("funcion"); }
;

ListaParametros : ListaParametros 'tk_,' ListaParam
                    {$$ = $1; $$.insertar($3); console.log("parametro");}
                | ListaParam
                    {$$ = new Lista.Lista(); $$.insertar($1); console.log("un parametro")}
;

ListaParam  : TipoDato Id       /*en lugar de valor va el id*/
                {$$ = new Primitivo.Primitivo($1, $2, @1.first_line, @1.first_column); console.log("pf");}
;

STransferencia  : 'tkBreak' 'tk_;'
                    {$$ = new Transferencia.Transferencia(true, false, false, null, null); console.log("break"); }
                | 'tkContinue' 'tk_;'
                    {$$ = new Transferencia.Transferencia(false, true, false, null, null); console.log("continue"); }
                | 'tkReturn' E 'tk_;'
                    {$$ = new Transferencia.Transferencia(false, false, true, $2, null); console.log("return Expresion"); }
                | 'tkReturn' 'tk_;'
                    {$$ = new Transferencia.Transferencia(false, false, true, null, null); console.log("return"); }
                | 'tkReturn' SLlamada 
                    {$$ = new Transferencia.Transferencia(false, false, true, null, $2); console.log("return"); }
;

SLlamada    : Id 'tk_(' 'tk_)' 'tk_;'
                {$$ = new Llamada.Llamada($1, null); console.log("llamada vacia"); }
            | Id 'tk_(' ListaExpresiones 'tk_)' 'tk_;'
                {$$ = new Llamada.Llamada($1, $3.getLista()); console.log("llamada"); }
;

ListaExpresiones : ListaExpresiones 'tk_,' E
                    {$$ = $1; $$.insertar($3); console.log("exp");}
                | E
                    {$$ = new Lista.Lista(); $$.insertar($1); console.log("un exp")}
;



E   : E 'tk_>' E 
        {$$ = new Operacion.Operacion($1, $3, "Mayor", "r", @1.first_line, @1.first_column); }
    | E 'tk_<' E 
        {$$ = new Operacion.Operacion($1, $3, "Menor", "r", @1.first_line, @1.first_column); }
    | E 'tk_>=' E 
        {$$ = new Operacion.Operacion($1, $3, "MayorIgual", "r", @1.first_line, @1.first_column); }
    | E 'tk_<=' E 
        {$$ = new Operacion.Operacion($1, $3, "MenorIgual", "r", @1.first_line, @1.first_column); }
    | E 'tk_==' E 
        {$$ = new Operacion.Operacion($1, $3, "Igual", "r", @1.first_line, @1.first_column); }
    | E 'tk_!=' E 
        {$$ = new Operacion.Operacion($1, $3, "NoIgual", "r", @1.first_line, @1.first_column); }
    | E 'tk_&&' E 
        {$$ = new Operacion.Operacion($1, $3, "And", "l", @1.first_line, @1.first_column); }
    | E 'tk_||' E 
        {$$ = new Operacion.Operacion($1, $3, "Or", "l", @1.first_line, @1.first_column); }
    | 'tk_!' E %prec '!'
        {$$ = new Unario.Unario($2, Unario.TipoUnario.Neg, @1.first_line, @1.first_column); }    
    | E 'tk_+' E
        {$$ = new Operacion.Operacion($1, $3, "Suma", "a", @1.first_line, @1.first_column); }
    | E 'tk_-' E
        {$$ = new Operacion.Operacion($1, $3, "Resta", "a", @1.first_line, @1.first_column); }
    | E 'tk_*' E
        {$$ = new Operacion.Operacion($1, $3, "Multiplicacion", "a", @1.first_line, @1.first_column); }
    | E 'tk_/' E
        {$$ = new Operacion.Operacion($1, $3, "Division", "a", @1.first_line, @1.first_column); }
    | E 'tk_%' E
        {$$ = new Operacion.Operacion($1, $3, "Modulo", "a", @1.first_line, @1.first_column); }
    | E 'tk_^' E
        {$$ = new Operacion.Operacion($1, $3, "Potencia", "a", @1.first_line, @1.first_column); }
    | 'tk_-' E %prec UNM
        {$$ = new Unario.Unario($2, Unario.TipoUnario.UMenos, @1.first_line, @1.first_column); }        
    | 'tk_(' E 'tk_)'
        {$$ = $2; }
    | E 'tk_--'
        {$$ = new Unario.Unario($1, Unario.TipoUnario.MenosMenos, @1.first_line, @1.first_column); console.log("decremento"); }
    | E 'tk_++'
        {$$ = new Unario.Unario($1, Unario.TipoUnario.MasMas, @1.first_line, @1.first_column); console.log("incremento"); }
    | Int
        {$$ = new Primitivo.Primitivo("Integer", $1, @1.first_line, @1.first_column); }
    | Double
        {$$ = new Primitivo.Primitivo("Double", $1, @1.first_line, @1.first_column); }
    | Cadena
        {$$ = new Primitivo.Primitivo("String", $1, @1.first_line, @1.first_column); }
    | Char
        {$$ = new Primitivo.Primitivo("Char", $1, @1.first_line, @1.first_column); }
    | Boolean
        {$$ = new Primitivo.Primitivo("Boolean", $1, @1.first_line, @1.first_column); }
    | Id
        {$$ = new Primitivo.Primitivo("Id", $1, @1.first_line, @1.first_column); }
;
