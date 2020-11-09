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
	: INSTRUCCIONES EOF 
	{
		$$ = new Nodo("INI","");
		$$.add($1);

		return {ast:$$,tbl:tbl_error}
	}
;

INSTRUCCIONES
	: INSTRUCCIONES INSTRUCCION 	
	{
		$1.add($2);
		$$ = $1;
	}
	| INSTRUCCION					
	{
		$$ = new Nodo("INSTRUCCIONES","");
		$$.add($1);
	}
;

INSTRUCCION
	: MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq DECLARACION_METODO sllaveder 
	{
		$$ = new Nodo("CLASE_INTERFACE","");
		$$.add($1);
		$$.add($2);
		$$.add(new Nodo($3,""));
		$$.add(new Nodo($4,""));
		$$.add($5);
		$$.add(new Nodo($6,""));
	}	
	
	| MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq  sllaveder 
	{
		$$ = new Nodo("CLASE_INTERFACE","");
		$$.add($1);
		$$.add($2);
		$$.add(new Nodo($3,""));
		$$.add(new Nodo($4,""));
		$$.add(new Nodo($5,""));
	}		
;

MODIFICADOR
	:rpublic 	{$$=new Nodo($1,"");}
	|rprivate	{$$=new Nodo($2,"");}
;

CLASE_INTERFACE
	:rclass		
	{
		$$ = new Nodo($1,"");
	}	
	|rinterface 
	{
		$$ = new Nodo($1,"");
	}	
;

DECLARACION_METODO
	:DECLARACION_METODO DECLARACION 
	{
		$1.add($2);
		$$ = $1;
	}
	|DECLARACION
	{
		$$ = new Nodo("DECLARACION_METODO","");
		$$.add($1);
	}
	|DECLARACION_METODO ASIGNACION
	{
		$1.add($2);
		$$ = $1;
	}
	|ASIGNACION
	{
		$$ = new Nodo("DECLARACION_METODO","");
		$$.add($1);
	}
	|DECLARACION_METODO METODO
	{
		$1.add($2);
		$$ = $1;
	}
	|METODO
	{
		$$ = new Nodo("DECLARACION_METODO","");
		$$.add($1);
	}
;

METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
		$$ = new Nodo("METODO","");
		$$.add($1);
		$$.add($2);
		$$.add(new Nodo($3,""));
		$$.add(new Nodo($4,""));
		$$.add($5);
		$$.add($6);
	}	
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
		$$ = new Nodo("METODO","");
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add(new Nodo($3,""));
		$$.add(new Nodo($4,""));
		$$.add($5);
		$$.add($6);
	}
;

PARAMETROS
	: 			sparder   	
	{
		$$ = new Nodo("PARAMETROS","");
		$$.add(new Nodo($1,""));
	}

	}
	|  LIST_PAR sparder   	
	{
		$$ = new Nodo("PARAMETROS","");
		$$.add($1);
		$$.add(new Nodo($2,""));
	}
;

LIST_PAR
	:LIST_PAR scoma TIPO_DATO tkidentificador 	
	{
		$1.add($3);
		$1.add(new Nodo($4,""));
		$$ = $1;
	}
	| TIPO_DATO	tkidentificador						
	{
		$$ = new Nodo("LIST_PAR","");
		$$.add($1);
		$$.add(new Nodo($2,""));
	}
;

LI
	:LI ASIGNACION 				
	{
		$1.add($2);
		$$ = $1;
	}
	|ASIGNACION
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI DECLARACION 				
	{
		$1.add($2);
		$$ = $1;
	}
	|DECLARACION
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI SENTENCIA_REPETICION
	{
		$1.add($2);
		$$ = $1;
	}
	|SENTENCIA_REPETICION
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI SENTENCIA_CONTROL
	{
		$1.add($2);
		$$ = $1;
	}
	|SENTENCIA_CONTROL
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
;

SENTENCIA_CONTROL
	:IF	
	{
		$$ = new Nodo("SENTENCIA_CONTROL","");
		$$.add($1);
	}
;

SENTENCIA_REPETICION
	:rfor sparizq  EXPRESION spuntocoma	EXPRESION spuntocoma EXPRESION sparder  STATCOR 
	{
		$$ = new Nodo("FOR","");
		$$.add($3);
		$$.add($5);
		$$.add($7);
		$$.add($10);
	}
	|rwhile sparizq EXPRESION sparder  STATCOR 
	{
		$$ = new Nodo("WHILE","");
		$$.add($3);
		$$.add($6);
	}
	|rdo sllaveizq STATCOR sllaveder rwhile sparizq EXPRESION sparder spuntocoma
	{
		$$ = new Nodo("DO_WHILE","");
		$$.add($3);
		$$.add($7);
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
		$$.add(new Nodo($1,""));
		$$.add($2);
	}	
;

STATCORPRIMA
	: LI 	sllaveder			
	{
		$$ = new Nodo("STATCORPRIMA","");
		$$.add($1);
		$$.add(new Nodo($2,""));
	}		
    | sllaveder		 	
	{
		$$ = new Nodo("STATCORPRIMA","");
		$$.add(new Nodo($1,""));
	}
;

DECLARACION
	: TIPO_DATO LISTA_ID  spuntocoma
	 {
		$$ = new Nodo("DECLARACION","");
		$$.add($1);
		$$.add($2);
	 }
	| TIPO_DATO LISTA_ID sigual VALOR spuntocoma
	 {
		$$ = new Nodo("DECLARACION","");
		$$.add($1);
		$$.add($2);
		$$.add($4);
	 }
;

ASIGNACION
	:LISTA_ID sigual VALOR spuntocoma
	{
		$$ = new Nodo("ASIGNACION","");
		$$.add($1);
		$$.add($3);
	 }
;

LISTA_ID
	: LISTA_ID scoma tkidentificador
	{
		$1.add(new Nodo($3,"identificador"));
		$$=$1;			
	}
	|tkidentificador
	{
		$$ = new Nodo("LISTA_ID","");
		$$.add(new Nodo($1,"identificador"));
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
	/*
	
	//| error 
	//{
		//msg = "Error Sintactico en:"+$1+"ERROR"+$1+" en la linea:" + this._$1.first_line + " en la Columna: " + this._$1.first_column;
		//tbl_error.push(msg);
		//console.log(msg);
	//}

	*/
;