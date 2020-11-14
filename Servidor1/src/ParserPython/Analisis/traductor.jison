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
"System.out.println"  
"System.out.print"  
"return"  
"public"  
"private"  			
"static"  				
"String[]"  		
"args"  			
"main"  			
"class"  			
"INTERFACE"  		
"false"				
"true"				

"int"				
"bool"				
"double"				
"string"			
"char"				
"void"				

"while"				
"do"				
"if"				
"else"				
"for"				
"break"				

//Simbolos

";"					
","					
"{"				
"}"					
"("					
")"					

		
"+"					
"-"					
"*"					
"/"		

"<"					
">"					
"="		
"^"				
"!"					

"++"				
"--"			
"&&"				
"||"				

"<="				
">="				
"=="				
"!="			
[0-9]+"."[0-9]*

[0-9]+\b	

([a-zA-Z])[a-zA-Z0-9_]*	

([\"][^"]*[\"]) 
([\'][^']*[\']) 


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
		$$ = $1;
		return  {
					traduccion:$$
				};
	}
;

MAIN
	:rpublic rstatic rvoid rmain sparizq rstring rargs sparder STATCOR
	{
		$$ = "\nmain( args )"+$9;
	}
;

INSTRUCCIONES
	: INSTRUCCIONES INSTRUCCION 	
	{
		$$ = $1+$2;
	}
	| INSTRUCCION					
	{
		$$ = $1;
	}
;

INSTRUCCION
	: MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq INS_CLASE sllaveder 
	{
		var result ="";
		if($2!="interface")
		{
			result+="class "+$3+" {\n"+$5+"\n}\n";
		}
		$$ = result;
	}	
	| MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq  sllaveder 
	{
		var result ="";
		if($2!="interface")
		{
			result+="class "+$2+" {\n\n}\n";
		}
		$$ = result;
	}	
;

MODIFICADOR
	:rpublic 	
	{
		var result =$1;
		 $$ = result;
	}
	|rprivate	
	{
		var result =$1
		 $$ = result;
	}
;

CLASE_INTERFACE
	:rclass		
	{
		$$ = $1;
	}	
	|rinterface 
	{
		$$ = $1;
	}	
;

INS_CLASE
	:INS_CLASE DECLARA_ASIGN {
		 $$ = $1+$2+"\n";
	}
	|DECLARA_ASIGN
	{
		$$ = $1+"\n";
	}
	|INS_CLASE LLAMADA_FUNCION 
	{
		 $$ = $1+$2;
	}
	|LLAMADA_FUNCION
	{
		$$ = $1;
	}
	|INS_CLASE IMP_METODO
	{
		 $$ = $1+$2;
	}
	|IMP_METODO
	{
		$$ = $1;
	}
	|INS_CLASE MAIN
	{
		 $$ = $1+$2;
	}
	|MAIN	
	{
		$$ = $1;
	}
	|INS_CLASE DEC_METODO
	{
		 $$ = $1+$2;
	}
	|DEC_METODO	
	{
		$$ = $1;
	}
	|INS_CLASE EXP_AUMENTO spuntocoma 
	{
		 $$ = $1+$2+$3;
	}
	|EXP_AUMENTO spuntocoma
	{
		$$ = $1+$2;
	}
;

BREAK_CONTINUE
	:rbreak spuntocoma
	{
		$$ = $1+$2;
	}
	|rcontinue spuntocoma
	{
		$$ = $1+$2;
	}
;


RETORNO
	: rreturn EXP spuntocoma
	{
		$$ = ""+$1+" "+$2+" "+$3;;
	}
;

PRINT
	:rprint sparizq EXP sparder spuntocoma
	{
		$$ = "\nconsole.log( "+$3+" );\n";
	}
	|rprintln sparizq EXP sparder spuntocoma
	{
		$$ = "\nconsole.log( "+$3+" );\n";
	}

;


DEC_METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS   spuntocoma
	{
		var result =""
		$$ = result;
	}	
	|TIPO_DATO tkidentificador sparizq  PARAMETROS    spuntocoma
	{
		var result =""
		$$ = result;
	}	
	| rvoid tkidentificador sparizq  PARAMETROS  spuntocoma
	{
		var result =""
		$$ = result;
	}
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS  spuntocoma
	{
		var result =""
		$$ = result;
	}
	|error
	{
	}
;

IMP_METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
		var result ="\n"+$3+"("+$5+""+$6;
		$$ = result;
	}	
	|TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
		var result ="\n"+$2+"("+$4+""+$5;
		$$ = result;
	}	
	| rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
		var result ="\n"+$2+"("+$4+""+$5;
		$$ = result;
	 }
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
		var result ="\n"+$3+"("+$5+""+$6;
		$$ = result;
	}
;

PARAMETROS
	: 			sparder   	
	{
		$$ = " )";
	}
	|  LIST_PAR sparder   	
	{
		var result =$1+" )";
		$$ = result;
	}
;

LIST_PAR
	:LIST_PAR scoma TIPO_DATO tkidentificador 	
	{
		$$ = $1+", "+$4;
	}
	| TIPO_DATO	tkidentificador						
	{
		$$ =$2;
	}
;

LI
	:LI DECLARA_ASIGN 				
	{
		$$ = $1+$2+"\n";
	}
	|DECLARA_ASIGN
	{
		$$ = $1+"\n";
	}
	|LI LLAMADA_FUNCION 
	{
		$$ = $1+$2;
	}
	|LLAMADA_FUNCION
	{
		$$ = $1;
	}
	|LI SENTENCIA_REPETICION
	{
		$$ = $1+$2;
	}
	|SENTENCIA_REPETICION
	{
		$$ = $1;
	}
	|LI SENTENCIA_CONTROL
	{
		$$ = $1+$2;
	}
	|SENTENCIA_CONTROL
	{
		$$ = $1;
	}
	|LI RETORNO
	{
		$$ = $1+$2;
	}
	|RETORNO
	{
		$$ = $1;
	}
	|LI PRINT
	{
		$$ = $1+$2;
	}
	|PRINT
	{
		$$ = $1;
	}
	|LI BREAK_CONTINUE
	{
		$$ = $1+$2;
	}
	|BREAK_CONTINUE
	{
		$$ = $1;
	}
	|LI EXP_AUMENTO spuntocoma 
	{
		$$ = $1+$2;
	}
	|EXP_AUMENTO spuntocoma
	{
		$$ = $1;
	}
;

SENTENCIA_CONTROL
	:IF	
	{
		$$ = $1;
	}
;

SENTENCIA_REPETICION
	:rfor sparizq  DECLARA_ASIGN EXP spuntocoma EXP_AUMENTO sparder  STATCOR 
	{
		$$ = $1+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+$8;
	}
	|rwhile sparizq EXP sparder  STATCOR 
	{
		$$ = $1+$2+" "+$3+" "+$4+$5;
	}
	|rdo  STATCOR  rwhile sparizq EXP sparder spuntocoma
	{
		$$ = "\n"+$1+$2+$3+$4+$5+$6+$7;
	}
;

LISTA_IF
	:LISTA_IF IF
	{
		$$ = $1+" "+$2;
	}
	|IF
	{
		$$ = $1;
	}
;

IF  
	: rif sparizq EXP sparder  STATCOR  OTHERELSE
	{
		$$ = $1+$2+" "+$3+" "+$4+$5+$6;
	}
    | rif sparizq EXP sparder STATCOR 
	{
		$$ = $1+$2+" "+$3+" "+$4+$5;
	}
;

OTHERELSE 
	: LELSEIF relse STATCOR	
	{
		$$ = $1+$2+$3;
	}
    |         relse STATCOR	
	{
		$$ = $1+$2;
	}	
	| LELSEIF  	
	{
		$$ = $1;
	}
;

LELSEIF 
	: LELSEIF ELSEIF	
	{
		$$ = $1+$2;
	}
    | ELSEIF			
	{
		$$ = $1;
	}
;

ELSEIF  
	: relse rif sparizq EXP sparder  STATCOR	
	{
		$$ = $1+" "+$2+$3+$4+$5+$6;
	}
;

STATCOR 
	:sllaveizq  STATCORPRIMA  
	{
		$$ = $1+$2;
	}	
;

STATCORPRIMA
	: LI 	sllaveder			
	{
		var result =$1+"\n}"
		$$ = result;
	}		
    | sllaveder		 	
	{
		$$ = "\n}";
	}
	|error sllaveder
	{
		var result =""
		$$ = result;
	}
;

LLAMADA_FUNCION
	:tkidentificador sparizq   LISTA_VALOR_PARAMETRO sparder spuntocoma 
	{
		$$ = $1+$2+$3+$4+"; ";
	}
;

LISTA_VALOR_PARAMETRO
	: LISTA_VALOR_PARAMETRO scoma EXP
	{
		$$ = $1+", "+$3;
	}
	| EXP
	{
		$$ = $1;
	}
;	

DECLARA_ASIGN
	: TIPO_DATO LISTA_ID  spuntocoma
	{
		$$ = "var "+$2+"; ";
	}
	|LISTA_ID   spuntocoma
	{
		$$ = $1+"; ";
	}
	|error spuntocoma
	{
		var result =""
		 $$ = result;
	}
;

LISTA_ID
	: LISTA_ID scoma ID_IGUAL_EXP
	{
		$$ = $1+", "+$3;
	}
	|ID_IGUAL_EXP
	{
		$$ = $1;
	}
;

ID_IGUAL_EXP
	:tkidentificador sigual EXP
	{
		$$ = " "+$1+" "+$2+" "+$3;
	}
	|tkidentificador 
	{
		$$ = " "+$1;
	}
;



TIPO_DATO
	:rint	
	{
		var result =""
		 $$ = result;
	}	
	|rbool	
	{
		var result =""
		 $$ = result;
	}	
	|rfloat	
	{
		var result =""
		 $$ = result;
	}	
	|rstring	
	{
		var result =""
		 $$ = result;
	}	
	|rchar	
	{
		var result =""
		 $$ = result;
	}	
;

EXP
	: EXP sand EXP     
	{
		$$=$1+" "+$2+" "+$3;
	}	
	| EXP sor EXP 		
	{
		$$=$1+" "+$2+" "+$3;
	}	
	| EXP sxor EXP 		
	{
		$$=$1+" "+$2+" "+$3;
	}	
	| snot EXP							
	{
		$$=$1+" "+$2;
	}	
	| EXP smayque EXP			
	{
		$$=$1+" "+$2+" "+$3;
	}	
	| EXP smenque EXP		
	{
		$$=$1+" "+$2+" "+$3;
	}	
	| EXP smayigque EXP	
	{
		$$=$1+" "+$2+" "+$3;
	}	
	|  EXP smenigque EXP	
	{
		$$=$1+" "+$2+" "+$3;
	}	
	| EXP sdobleig EXP			
	{
		$$=$1+" "+$2+" "+$3;
	}	
	|EXP snoig EXP			
	{
		$$=$1+" "+$2+" "+$3;
	}	
	|smenos EXP %prec UMENOS 
	{
		$$=$1+$2
	}
	|EXP smas EXP
	{
		$$=$1+" "+$2+" "+$3;
	}
	|EXP smenos EXP
	{
		$$=$1+" "+$2+" "+$3;
	}
	|EXP spor EXP
	{	
		$$=$1+" "+$2+" "+$3;
	}
	|EXP sdiv EXP
	{
		$$=$1+" "+$2+" "+$3;
	}
	|sparizq EXP sparder 
	{
		$$=$1+" "+$2+" "+$3;
	}
	|EXP_AUMENTO
	{
		$$=$1;
	}
	| VALOR	
	{
		$$=$1;
	}
;

VALOR 
	:tkstring
	{
		$$=$1;
	}
	|tkstring2
	{
		$$=$1;
	}
	| rfalse	
	{
		$$=$1;
	}
	| rtrue		
	{
		$$=$1;
	}
	|tkidentificador 
	{
		$$=$1;
	}
	|tkflotante 
	{
		$$=$1;
	}	
	|tkentero 
	{
		$$=$1;
	}	
;

EXP_AUMENTO
	:tkidentificador  adicion
	{
		$$ = " "+$1+$2;
	}
	|tkidentificador sustraccion
	{
		$$ = " "+$1+$2;
	}
;