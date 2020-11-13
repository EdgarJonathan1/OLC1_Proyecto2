/**
 * Ejemplo Intérprete Sencillo con Jison utilizando Nodejs en Archlinux
 */

/* Definición Léxica */
%{


	
%}
%lex

%options case-insensitive
%%

\s+											// se ignoran espacios en blanco
"//".*										// comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			// comentario multiple líneas


//Palabras Reservadas

"continue"  
 					{
						var tipo = 'rcontinue';
						return tipo;      
					}
"System.out.println"  
 					{
						var tipo = 'rprintln';
						return tipo;      
					}
"System.out.print"  
 					{
						var tipo = 'rprint';
						return tipo;      
					}
"return"  
 					{
						var tipo = 'rreturn';
						return tipo;      
					}
"public"  
 					{
						var tipo = 'rpublic';
						return tipo;      
					}

"private"  			
 					{
						var tipo = 'rprivate';
						return tipo;      
					}
"static"  			
 					{
						var tipo = 'rstatic';
						return tipo;      
					}
"String[]"  		
 					{
						var tipo = 'rstring';
						return tipo;      
					}
"args"  			
 					{
						var tipo = 'rargs';
						return tipo;      
					}
"main"  			
 					{
						var tipo = 'rmain';
						return tipo;      
					}
"class"  			
 					{
						var tipo = 'rclass';
						return tipo;      
					}
"INTERFACE"  		
 					{
						var tipo = 'rinterface';
						return tipo;      
					}
"false"				
 					{
						var tipo = 'rfalse';
						return tipo;      
					}
"true"				
 					{
						var tipo = 'rtrue';
						return tipo;      
					}

//Tipos de dato
"int"				
 					{
						var tipo = 'rint';
						return tipo;      
					}
"bool"				
 					{
						var tipo = 'rbool';
						return tipo;      
					}
"double"				
 					{
						var tipo = 'rfloat';
						return tipo;      
					}
"string"			
 					{
						var tipo = 'rstring';
						return tipo;      
					}
"char"				
 					{
						var tipo = 'rchar';
						return tipo;      
					}
"void"				
 					{
						var tipo = 'rvoid';
						return tipo;      
					}

"while"				
 					{
						var tipo = 'rwhile';
						return tipo;      
					}
"do"				
 					{
						var tipo = 'rdo';
						return tipo;      
					}
"if"				
 					{
						var tipo = 'rif';
						return tipo;      
					}
"else"				
 					{
						var tipo = 'relse';
						return tipo;      
					}
"for"				
 					{
						var tipo = 'rfor';
						return tipo;      
					}
"switch"			
 					{
						var tipo = 'rswitch';
						return tipo;      
					}
"case"				
 					{
						var tipo = 'rcase';
						return tipo;      
					}
"default"			
 					{
						var tipo = 'rdefault';
						return tipo;      
					}
"break"				
 					{
						var tipo = 'rbreak';
						return tipo;      
					}

//Simbolos

":"			
 					{
						var tipo = 'sdospuntos';
						return tipo;      
					}
";"					
 					{
						var tipo = 'spuntocoma';
						return tipo;      
					}
","					
 					{
						var tipo = 'scoma';
						return tipo;      
					}
"{"				
 					{
						var tipo = 'sllaveizq';
						return tipo;      
					}
"}"					
 					{
						var tipo = 'sllaveder';
						return tipo;      
					}
"("					
 					{
						var tipo = 'sparizq';
						return tipo;      
					}
")"					
 					{
						var tipo = 'sparder';
						return tipo;      
					}

"++"				
 					{
						var tipo = 'adicion';
						return tipo;      
					}
"--"			
 					{
						var tipo = 'sustraccion';
						return tipo;      
					}
"+="		
 					{
						var tipo = 'smasigual';
						return tipo;      
					}
"-="				
 					{
						var tipo = 'smenosigual';
						return tipo;      
					}
"*="				
 					{
						var tipo = 'sporigual';
						return tipo;      
					}
"/="				
 					{
						var tipo = 'sdivigual';
						return tipo;      
					}
"&&"				
 					{
						var tipo = 'sand';
						return tipo;      
					}
"||"				
 					{
						var tipo = 'sor';
						return tipo;      
					}

"+"					
 					{
						var tipo = 'smas';
						return tipo;      
					}
"-"					
 					{
						var tipo = 'smenos';
						return tipo;      
					}
"*"					
 					{
						var tipo = 'spor';
						return tipo;      
					}
"/"					
 					{
						var tipo = 'sdiv';
						return tipo;      
					}

"<="				
 					{
						var tipo = 'smenigque';
						return tipo;      
					}
">="				
 					{
						var tipo = 'smayigque';
						return tipo;      
					}
"=="				
 					{
						var tipo = 'sdobleig';
						return tipo;      
					}
"!="				
 					{
						var tipo = 'snoig';
						return tipo;      
					}

"<"					
 					{
						var tipo = 'smenque';
						return tipo;      
					}
">"					
 					{
						var tipo = 'smayque';
						return tipo;      
					}
"="		
 					{
						var tipo = 'sigual';
						return tipo;      
					}
"^"				
 					{
						var tipo = 'sxor';
						return tipo;      
					}


"!"					
 					{
						var tipo = 'snot';
						return tipo;      
					}

[0-9]+\b	
 					{
						var tipo = 'tkentero';
						return tipo;      
					}
[0-9]+("."[0-9]+)?  
 					{
						var tipo = 'tkflotante';
						return tipo;      
					}
([a-zA-Z])[a-zA-Z0-9_]*	
 					{
						var tipo = 'tkidentificador';
						return tipo;      
					}

([\"][^"]*[\"]) 
 					{
						var tipo = 'tkstring';
						return tipo;      
					}
([\'][^']*[\']) 
 					{
						var tipo = 'tkstring2';
						return tipo;      
					}

//[\"]([^\"\n]|(\\\"))*[\"]       { console.log('Reconocion Cadena xd');  return 'tkstring';      }



<<EOF>>				return 'EOF';
.					{ 
						
					}

/lex


%{

%}


/* Asociación de operadores y precedencia */
%left  sor 
%left  sand 

%left  snoig sdobleig 
%left  smenque smayque smenigque smayigque

%left  smas smenos 
%left  spor  sdiv  
%left  sxor 

%right snot 
%right UMENOS

%left adicion sustraccion 

%start INI

/****************************************************************************************************/
%% /******************************* Definición de la gramática ***************************************/
/*****************************************************************************************************/
INI
	: INSTRUCCIONES EOF 
	{
		$$ = $1+"SI funciona el traductor";
		return {
					traduccion:$$
				};
	}
;

MAIN
	:rpublic rstatic rvoid rmain sparizq rstring rargs sparder STATCOR
	{
	}
;

INSTRUCCIONES
	: INSTRUCCIONES INSTRUCCION 	
	{
	}
	| INSTRUCCION					
	{
	}
;

INSTRUCCION
	: MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq INS_CLASE sllaveder 
	{
	}	
	| MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq  sllaveder 
	{
	}	
;

MODIFICADOR
	:rpublic 	
	{
	}
	|rprivate	
	{
	}
;

CLASE_INTERFACE
	:rclass		
	{
	}	
	|rinterface 
	{
	}	
;

INS_CLASE
	:INS_CLASE DECLARA_ASIGN 
	{
	}
	|DECLARA_ASIGN
	{
	}
	|INS_CLASE LLAMADA_FUNCION 
	{
	}
	|LLAMADA_FUNCION
	{
	}
	|INS_CLASE IMP_METODO
	{
	}
	|IMP_METODO
	{
	}
	|INS_CLASE MAIN
	{
	}
	|MAIN	
	{
	}
	|INS_CLASE DEC_METODO
	{
	}
	|DEC_METODO	
	{
	}
	|INS_CLASE EXP_AUMENTO spuntocoma 
	{
	}
	|EXP_AUMENTO spuntocoma
	{
	}
;

BREAK_CONTINUE
	:rbreak spuntocoma
	{
	}
	|rcontinue spuntocoma
	{
	}
;


RETORNO
	: rreturn EXP spuntocoma
	{
	}
;

PRINT
	:rprint sparizq EXP sparder spuntocoma
	{
	}
	|rprintln sparizq EXP sparder spuntocoma
	{
	}

;


DEC_METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS   spuntocoma
	{
	}	
	|TIPO_DATO tkidentificador sparizq  PARAMETROS    spuntocoma
	{
	}	
	| rvoid tkidentificador sparizq  PARAMETROS  spuntocoma
	{
	}
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS  spuntocoma
	{
	}
	|error
	{
	}
;

IMP_METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
	}	
	|TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
	}	
	| rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
	 }
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
	}
;

PARAMETROS
	: 			sparder   	
	{
	}

	}
	|  LIST_PAR sparder   	
	{
	}
;

LIST_PAR
	:LIST_PAR scoma TIPO_DATO tkidentificador 	
	{
	}
	| TIPO_DATO	tkidentificador						
	{
	}
;

LI
	:LI DECLARA_ASIGN 				
	{
	}
	|DECLARA_ASIGN
	{
	}
	|LI LLAMADA_FUNCION 
	{
	}
	|LLAMADA_FUNCION
	{
	}
	|LI SENTENCIA_REPETICION
	{
	}
	|SENTENCIA_REPETICION
	{
	}
	|LI SENTENCIA_CONTROL
	{
	}
	|SENTENCIA_CONTROL
	{
	}
	|LI RETORNO
	{
	}
	|RETORNO
	{
	}
	|LI PRINT
	{
	}
	|PRINT
	{
	}
	|LI BREAK_CONTINUE
	{
	}
	|BREAK_CONTINUE
	{
	}
	|LI EXP_AUMENTO spuntocoma 
	{
	}
	|EXP_AUMENTO spuntocoma
	{
	}
;

SENTENCIA_CONTROL
	:IF	
	{
	}
;

SENTENCIA_REPETICION
	:rfor sparizq  DECLARA_ASIGN EXP spuntocoma EXP_AUMENTO sparder  STATCOR 
	{
	}
	|rwhile sparizq EXP sparder  STATCOR 
	{
	}
	|rdo  STATCOR  rwhile sparizq EXP sparder spuntocoma
	{
	}
;

LISTA_IF
	:LISTA_IF IF
	{
	}
	|IF
	{
	}
;

IF  
	: rif sparizq EXP sparder  STATCOR  OTHERELSE
	{
	}
    | rif sparizq EXP sparder STATCOR 
	{
	}
;

OTHERELSE 
	: LELSEIF relse STATCOR	
	{
	}
    |         relse STATCOR	
	{
	}	
	| LELSEIF  	
	{
	}
;

LELSEIF 
	: LELSEIF ELSEIF	
	{
	}
    | ELSEIF			
	{
	}
;

ELSEIF  
	: relse rif sparizq EXP sparder  STATCOR	
	{
	}
;

STATCOR 
	:sllaveizq  STATCORPRIMA  
	{
	}	
;

STATCORPRIMA
	: LI 	sllaveder			
	{
	}		
    | sllaveder		 	
	{
	}
	|error sllaveder
	{
	}
;

LLAMADA_FUNCION
	:tkidentificador sparizq   LISTA_VALOR_PARAMETRO sparder spuntocoma 
	{
	}
;

LISTA_VALOR_PARAMETRO
	: LISTA_VALOR_PARAMETRO scoma EXP
	{
	}
	| EXP
	{
	}
;	

DECLARA_ASIGN
	: TIPO_DATO LISTA_ID  spuntocoma
	{
	}
	|LISTA_ID   spuntocoma
	{
	}
	|error spuntocoma
	{
	}
;

LISTA_ID
	: LISTA_ID scoma ID_IGUAL_EXP
	{
	}
	|ID_IGUAL_EXP
	{
	}
;

ID_IGUAL_EXP
	:tkidentificador sigual EXP
	{
	}
	|tkidentificador 
	{
	}
;



TIPO_DATO
	:rint	
	{
	}	
	|rbool	
	{
	}	
	|rfloat	
	{
	}	
	|rstring	
	{
	}	
	|rchar	
	{
	}	
;

EXP
	: EXP sand EXP     
	{
	}	
	| EXP sor EXP 		
	{
	}	
	| EXP sxor EXP 		
	{
	}	
	| snot EXP							
	{
	}	
	| EXP smayque EXP			
	{
	}	
	| EXP smenque EXP		
	{
	}	
	| EXP smayigque EXP	
	{
	}	
	|  EXP smenigque EXP	
	{
	}	
	| EXP sdobleig EXP			
	{
	}	
	|EXP snoig EXP			
	{
	}	
	|smenos EXP %prec UMENOS 
	{
	}
	|EXP smas EXP
	{	}
	|EXP smenos EXP
	{	}
	|EXP spor EXP
	{	}
	|EXP sdiv EXP
	{	}
	|sparizq EXP sparder 
	{
	}
	|EXP_AUMENTO
	{
	}
	| VALOR	
	{
	}
;

VALOR 
	:tkstring
	{
	}
	|tkstring2
	{
	}
	| rfalse	
	{
	}
	| rtrue		
	{
	}
	|tkidentificador 
	{
	}
	|tkflotante 
	{
	}	
	|tkentero 
	{
	}	
;

EXP_AUMENTO
	:tkidentificador  adicion
	{
	}
	|tkidentificador sustraccion
	{
	}
;