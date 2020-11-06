/**
 * Ejemplo Intérprete Sencillo con Jison utilizando Nodejs en Archlinux
 */

/* Definición Léxica */
%{
    //var AST = require("../AST/Entornos/AST");
	const {Nodo} = require('../Interprete/Nodo');
	const tbl_error=[];
	
%}
%lex

%options case-insensitive
%%

\s+											// se ignoran espacios en blanco
"//".*										// comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			// comentario multiple líneas


//Palabras Reservadas
"public"  			return 'rpublic'
"private"  			return 'rprivate'
"class"  			return 'rclass'
"INTERFACE"  		return 'rinterface'
"false"				return 'rfalse'
"true"				return 'rtrue'

//Tipos de dato
"int"				return 'rint';
"bool"				return 'rbool';
"float"				return 'rfloat';
"string"			return 'rstring';
"char"				return 'rchar'; 
"void"				return 'rvoid'; 

"while"				return 'rwhile';
"do"				return 'rdo';
"if"				return 'rif';
"else"				return 'relse';
"for"				return 'rfor';
"switch"			return 'rswitch';
"case"				return 'rcase';
"default"			return 'rdefault';
"break"				return 'rbreak';

//Simbolos

":"					return 'sdospuntos';
";"					return 'spuntocoma';
","					return 'scoma';
"{"					return 'sllaveizq';
"}"					return 'sllaveder';
"("					return 'sparizq';
")"					return 'sparder';

"+="				return 'smasigual';
"-="				return 'smenosigual';
"*="				return 'sporigual';
"/="				return 'sdivigual';
"&&"				return 'sand'
"||"				return 'sor';

"+"					return 'smas';
"-"					return 'smenos';
"*"					return 'spor';
"/"					return 'sdiv';

"<="				return 'smenigque';
">="				return 'smayigque';
"=="				return 'sdobleig';
"!="				return 'snoig';

"<"					return 'smenque';
">"					return 'smayque';
"="					return 'sigual';


"!"					return 'snot';

\"[^\"]*\"				{ yytext = yytext.substr(1,yyleng-2); return 'tkstring'; }
[0-9]+("."[0-9]+)?\b  	return 'tkflotante';
[0-9]+\b				return 'tkentero';
([a-zA-Z])[a-zA-Z0-9_]*	return 'tkidentificador';


<<EOF>>				return 'EOF';
.					{ console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }

/lex


%{

%}


/* Asociación de operadores y precedencia */

%left 'sor' 'sand'
%left 'smas' 'smenos'
%left 'spor' 'sdiv'
%left UMENOS

%start INI

/*****************************************************************************************************/
%% /******************************* Definición de la gramática ***************************************/
/*****************************************************************************************************/

INI
	:LISTA_IF  EOF 
	{
		$$ = new Nodo("INI","");
		$$.add($1);

		return {ast:$$,tbl:tbl_error}
	} 
;

LISTA_IF
	:LISTA_IF IF
	{
		$1.add($2);
		$$ = $1;
	}
	|IF
	{
		$$ = new Nodo("LISTA_IF","");
		$$.add($1);
	}
;

IF  : rif sparizq EXPRESION sparder  STATCOR  OTHERELSE
	{
		$$ = new Nodo("IF","");
		$$.add($3);
		$$.add($5);
		$$.add($6);
	}
    | rif sparizq EXPRESION sparder STATCOR 
	{
		$$ = new Nodo("IF","");
		$$.add($3);
		$$.add($5);
	}

;
OTHERELSE 
	: LELSEIF relse STATCOR	
	{
		$$ = new Nodo("OTHERELSE","");
		$$.add($1);
		$$.add(new Nodo($2,"relse"));
		$$.add($3);
	}
    |         relse STATCOR	
	{
		$$ = new Nodo("OTHERELSE","");
		$$.add(new Nodo($1,"relse"));
		$$.add($2);
	}	
	| LELSEIF  	
	{
		$$ = new Nodo("OTHERELSE","");
		$$.add($1);
	}
;
LELSEIF 
	: LELSEIF ELSEIF	
	{
		$1.add($2);
		$$ = $1;
	}
    | ELSEIF			
	{
		$$ = new Nodo("LELSEIF","");
		$$.add($1);
	}
;
ELSEIF  
	: relse rif sparizq EXPRESION sparder  STATCOR	
	{
		$$ = new Nodo("ELSEIF");
		$$.add($4);
	}
;
STATCOR 
	:sllaveizq  STATCORPRIMA  
	{
		$$ = new Nodo("STATCOR","");
		$$.add(new Nodo($1,"llaveizq"));
		$$.add($2);
	}
;
STATCORPRIMA
	: LI 	sllaveder			
	{
		$1.add($2);
		$$ = $1;
	}		
    |   	sllaveder		 	
	{
		$$ = new Nodo("STATCORPRIMA","");
		$$.add(new Nodo($1,"llaveder"));
	}
;
STATCORPRIMA
	: LI 	sllaveder			
	{
		$$ = new Nodo("STATCORPRIMA","");
		$$.add($1);
		$$.add($2,"llaveder");
	}		
    | sllaveder		 	
	{
		$$ = new Nodo("STATCORPRIMA","");
		$$.add($1,"llaveder");
	}
;

LI
	:LI DECLARACION 				
	{
		$1.add($2);
		$$ = $1;
	}
	|DECLARACION					
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
;

DECLARACION
	: TIPO_DATO tkidentificador sigual VALOR spuntocoma
	 {
		$$ = new Nodo("DECLARACION","");
		$$.add($1);
		$$.add(new Nodo($2,"identificador"));
		$$.add(new Nodo($3,"igual"));
		$$.add($4);
		$$.add(new Nodo($1,"puntocoma"));
	 }
;

TIPO_DATO
	:rint	
	{
		$$ = new Nodo("TIPO_DATO","");
		$$.add(new Nodo($1,"int"));
	}	
	|rbool	
	{
		$$ = new Nodo("TIPO_DATO","");
		$$.add(new Nodo($1,"bool"));
	}	
	|rfloat	
	{
		$$ = new Nodo("TIPO_DATO","");
		$$.add(new Nodo($1,"float"));
	}	
	|rstring	
	{
		$$ = new Nodo("TIPO_DATO","");
		$$.add(new Nodo($1,"string"));
	}	
	|rchar	
	{
		$$ = new Nodo("TIPO_DATO","");
		$$.add(new Nodo($1,"char"));
	}	

;

VALOR 
	:tkstring
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,"string"));
	}
	| rfalse	
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,"false"));
	}
	| rtrue		
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,"true"));
	}
	| EXPRESION
	{
		$$ = new Nodo("VALOR","")
		$$.add($1);
	}
;

EXPRESION 
	:EXPRESION sor 	EXPRESION
	{	
		$$ = new Nodo("E","")
		$$.add($1);
		$$.add(new Nodo($2,"or"));
		$$.add($3);
	}
	|EXPRESION sand EXPRESION	
	{
		$$ = new Nodo("E","")
		$$.add($1);
		$$.add(new Nodo($2,"and"));
		$$.add($3);
	}
	|EXPRESION smas EXPRESION
	{	
		$$ = new Nodo("E","")
		$$.add($1);
		$$.add(new Nodo($2,"suma"));
		$$.add($3);
	}
	|EXPRESION smenos EXPRESION
	{	
		$$ = new Nodo("E","")
		$$.add($1);
		$$.add(new Nodo($2,"resta"));
		$$.add($3);
	}
	|EXPRESION spor EXPRESION
	{	
		$$ = new Nodo("E","")
		$$.add($1);
		$$.add(new Nodo($2,"multiplicacion"));
		$$.add($3);
	}
	|EXPRESION sdiv EXPRESION
	{	
		$$ = new Nodo("E","")
		$$.add($1);
		$$.add(new Nodo($2,"division"));
		$$.add($3);
	}
	|tkidentificador 
	{
		$$ = new Nodo("E","")
		$$.add(new Nodo($1,"id"));
	}
	|tkflotante 
	{
		$$ = new Nodo("E","")
		$$.add(new Nodo($1,"flotante"));
	}	
	|sparizq EXPRESION sparder 
	{
		$$ = new Nodo("E","")
		$$.add($2);
	}	
	|smenos EXPRESION %prec UMENOS 
	{
		$$ = new Nodo("E","")
		$$.add($2);
	}
	| error 
	{
		msg = "Error Sintactico en:"+$1+"ERROR"+$2+" en la linea:" + this._$.first_line + " en la Columna: " + this._$.first_column;
		tbl_error.push(msg);
		console.log(msg);
	}
;


//---------------------------Gramatica Original
/*
INI
	: INSTRUCCIONES EOF {}
;

INSTRUCCIONES
	: INSTRUCCIONES INSTRUCCION 	{}
	| INSTRUCCION					{}
;

INSTRUCCION
	: MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq DECLARACION_METODO sllaveder 
	{}	
	
	| MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq  sllaveder 
	{}		
;


CLASE_INTERFACE
	:rclass		{$$=$1}	
	|rinterface {$$=$1}
;

DECLARACION_METODO
	:DECLARACION_METODO DECLARACION {}
	|DECLARACION_METODO METODO		{}	
	|DECLARACION					{}
	|METODO							{}
;

METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS
	{}	
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS
	{}
;

PARAMETROS
	: 			sparder  STATCOR 	{}
	| PARAMETRO sparder  STATCOR 	{}
;

LI
	:LI DECLARACION 				{}
	|DECLARACION					{}
	|LI SENTENCIA_REPETICION 		{}
	|SENTENCIA_REPETICION			{}	
	|LI SENTENCIA_CONTROL 			{}
	|SENTENCIA_CONTROL				{}	
;


SENTENCIA_CONTROL
	:IF	{}
;

IF  : rif sparizq EXPRESION sparder STATCOR  OTHERELSE
		{}
	| rif sparizq EXPRESION sparder STATCOR  LELSEIF
		{}
    | rif sparizq EXPRESION sparder STATCOR 
		{}
;
OTHERELSE : LELSEIF relse STATCOR	{}
          |         relse STATCOR	{}
;
LELSEIF : LELSEIF ELSEIF	{}
        | ELSEIF			{}
;
ELSEIF  
	: relse rif sparizq EXPRESION sparder  STATCOR	{}
;
STATCOR 
	:sllaveizq  STATCORPRIMA  {}
;
STATCORPRIMA
	: LI 	sllaveder			{}		
    |   	sllaveder		 	{}
;


SENTENCIA_REPETICION
	:rfor sparizq spuntocoma EXPRESION spuntocoma EXPRESION sparder sllaveizq LI sllaveder
		{}
	|rwhile sparizq EXPRESION sparder sllaveizq LI sllaveder
		{}
	|rdo sllaveizq LI sllaveder rwhile sparizq EXPRESION sparder spuntocoma
		{}
;

PARAMETRO
	: PARAMETRO scoma TIPO_DATO tkidentificador 	{}
	| TIPO_DATO	tkidentificador						{}
;


TIPO_DATO
	:rint		{}
	|rbool		{}
	|rfloat		{}
	|rstring	{}
	|rchar		{}
;

DECLARACION
	: TIPO_DATO tkidentificador sigual VALOR spuntocoma
	 {}
;

MODIFICADOR
	:rpublic 	{$$=$1}
	|rprivate	{$$=$1}
;

VALOR 
	:tkstring
	| rfalse	
	| rtrue	
	| EXPRESION	
;


EXPRESION 
	:EXPRESION smas EXPRESION
	{}
	|EXPRESION smenos EXPRESION
	{}
	|EXPRESION spor EXPRESION
	{}
	|EXPRESION sdiv EXPRESION
	{}
	|EXPRESION sor 	EXPRESION
	{}
	|EXPRESION sand EXPRESION	
	{}
	|tkidentificador 
	{}
	|tkentero 
	{}
	|tkflotante 
	{}
	|sparizq EXPRESION sparder 
	{}
	|smenos EXPRESION %prec UMENOS 
	{}
;

*/