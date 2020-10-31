/**
 * Ejemplo Intérprete Sencillo con Jison utilizando Nodejs en Archlinux
 */

/* Definición Léxica */
%{
    //var AST = require("../AST/Entornos/AST");
	const {Primitivo} = require('../Interprete/Expression/Primitivo');
	
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
	{} 
;

LISTA_IF
	:LISTA_IF IF
	{}
	|IF
	{}
;

IF  : rif sparizq EXPRESION sparder STATCOR  OTHERELSE
		{}
    | rif sparizq EXPRESION sparder STATCOR 
		{}
;
OTHERELSE 
	: LELSEIF relse STATCOR	
	{}
    |         relse STATCOR	
	{}	
	| LELSEIF  	
	{}
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

LI
	:LI DECLARACION 				{}
	|DECLARACION					{}
;
DECLARACION
	: TIPO_DATO tkidentificador sigual VALOR spuntocoma
	 {}
;

TIPO_DATO
	:rint		{}
	|rbool		{}
	|rfloat		{}
	|rstring	{}
	|rchar		{}
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
	{
		console.log('estamos en identificador');
		$$=new Primitivo('id',$1,@1.first_line,@1.first_column);
	}
	|tkflotante 
	{
		console.log('estamos en Punto flotante');
		$$=new Primitivo('float',$1,@1.first_line,@1.first_column);
	}	
	|sparizq EXPRESION sparder 
	{
				
	}
	|smenos EXPRESION %prec UMENOS 
	{}
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