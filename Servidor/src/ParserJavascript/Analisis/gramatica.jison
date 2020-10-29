/**
 * Ejemplo Intérprete Sencillo con Jison utilizando Nodejs en Archlinux
 */

/* Definición Léxica */
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
	//const TIPO_OPERACION	= require('./INSTRUCCIONES').TIPO_OPERACION;
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
	:E  EOF 
	{
	} 
;
E
	:rpublic {console.log('Se reconadfadajdlsfksocio public');}

;

/*
E 
	:E smas E
	//{$$= new Aritmetica($1,$3,"suma", @1.first_line, @1.first_column);}
	|E smenos E
	//{$$ = new Operacion($1, $3, "Resta", "a", @1.first_line, @1.first_column); }
	|E spor E
	//{$$ = new Operacion($1, $3, "Multplicacion", "a", @1.first_line, @1.first_column); }
	|E sdiv E
	//{$$ = new Operacion($1, $3, "Division", "a", @1.first_line, @1.first_column); }
	|E sor 	E
	//{$$ = new Operacion($1, $3, "Or", "l", @1.first_line, @1.first_column); }
	|E sand E	
	//{$$ = new Operacion($1, $3, "And", "l", @1.first_line, @1.first_column); }
	|tkidentificador 
	//{$$ = new Primitivo.Primitivo("Id", $1, @1.first_line, @1.first_column); }
;

*/

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
EXPRESION
	:tkidentificador
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
	: TIPO_DATO tkidentificador sigual
	 {console.log("prueba");  }//Falta agregar aca xd
;

MODIFICADOR
	:rpublic 	{$$=$1}
	|rprivate	{$$=$1}
;
*/