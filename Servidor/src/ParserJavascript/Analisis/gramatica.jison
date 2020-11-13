/**
 * Ejemplo Intérprete Sencillo con Jison utilizando Nodejs en Archlinux
 */

/* Definición Léxica */
%{
    //var AST = require("../AST/Entornos/AST");
	const {Nodo} = require('../Interprete/Nodo');

    const {ListaToken} = require("../Interprete/ListaToken");
    const {Token} = require("../Interprete/Token");
    var LToken = new ListaToken();

	function addToken(data)
	{
		LToken.insertar(new Token(data[0],data[1],data[2],data[3]));
	}

	//Llenando en una lista los errores obtenidos
    const {ListaError} = require("../Interprete/ListaError");
    const {Error} = require("../Interprete/Error");
    var LError = new ListaError();

    function addErr(data) 
    {
		var descripcion = "";
		var tipo  =  data[data.length-1];
		let linea = data[0];
		let columna = data[1];
		if(tipo == 0)//Es un error lexico
		{
		 	descripcion = "El caracter: "+data[2]+" No pertenece al lenguaje";
			tipo = "Lexico";
		}else//Es un error sintactico
		{ 
		 	descripcion = "Recuperandose con "+data[2]+" En modo Panico!!!";
			tipo = "Sintactico";
		}

        LError.insertar(new Error(tipo,linea,columna,descripcion)); 
    }

	
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
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"System.out.println"  
 					{
						var tipo = 'rprintln';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"System.out.print"  
 					{
						var tipo = 'rprint';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"return"  
 					{
						var tipo = 'rreturn';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"public"  
 					{
						var tipo = 'rpublic';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

"private"  			
 					{
						var tipo = 'rprivate';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"static"  			
 					{
						var tipo = 'rstatic';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"String[]"  		
 					{
						var tipo = 'rstring';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"args"  			
 					{
						var tipo = 'rargs';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"main"  			
 					{
						var tipo = 'rmain';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"class"  			
 					{
						var tipo = 'rclass';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"INTERFACE"  		
 					{
						var tipo = 'rinterface';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"false"				
 					{
						var tipo = 'rfalse';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"true"				
 					{
						var tipo = 'rtrue';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

//Tipos de dato
"int"				
 					{
						var tipo = 'rint';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"bool"				
 					{
						var tipo = 'rbool';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"double"				
 					{
						var tipo = 'rfloat';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"string"			
 					{
						var tipo = 'rstring';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"char"				
 					{
						var tipo = 'rchar';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"void"				
 					{
						var tipo = 'rvoid';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

"while"				
 					{
						var tipo = 'rwhile';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"do"				
 					{
						var tipo = 'rdo';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"if"				
 					{
						var tipo = 'rif';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"else"				
 					{
						var tipo = 'relse';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"for"				
 					{
						var tipo = 'rfor';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"switch"			
 					{
						var tipo = 'rswitch';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"case"				
 					{
						var tipo = 'rcase';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"default"			
 					{
						var tipo = 'rdefault';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"break"				
 					{
						var tipo = 'rbreak';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

//Simbolos

":"			
 					{
						var tipo = 'sdospuntos';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
";"					
 					{
						var tipo = 'spuntocoma';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
","					
 					{
						var tipo = 'scoma';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"{"				
 					{
						var tipo = 'sllaveizq';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"}"					
 					{
						var tipo = 'sllaveder';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"("					
 					{
						var tipo = 'sparizq';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
")"					
 					{
						var tipo = 'sparder';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

"++"				
 					{
						var tipo = 'adicion';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"--"			
 					{
						var tipo = 'sustraccion';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"+="		
 					{
						var tipo = 'smasigual';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"-="				
 					{
						var tipo = 'smenosigual';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"*="				
 					{
						var tipo = 'sporigual';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"/="				
 					{
						var tipo = 'sdivigual';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"&&"				
 					{
						var tipo = 'sand';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"||"				
 					{
						var tipo = 'sor';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

"+"					
 					{
						var tipo = 'smas';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"-"					
 					{
						var tipo = 'smenos';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"*"					
 					{
						var tipo = 'spor';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"/"					
 					{
						var tipo = 'sdiv';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

"<="				
 					{
						var tipo = 'smenigque';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
">="				
 					{
						var tipo = 'smayigque';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"=="				
 					{
						var tipo = 'sdobleig';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"!="				
 					{
						var tipo = 'snoig';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

"<"					
 					{
						var tipo = 'smenque';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
">"					
 					{
						var tipo = 'smayque';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"="		
 					{
						var tipo = 'sigual';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
"^"				
 					{
						var tipo = 'sxor';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}


"!"					
 					{
						var tipo = 'snot';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

[0-9]+\b	
 					{
						var tipo = 'tkentero';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
[0-9]+("."[0-9]+)?  
 					{
						var tipo = 'tkflotante';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
([a-zA-Z])[a-zA-Z0-9_]*	
 					{
						var tipo = 'tkidentificador';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

([\"][^"]*[\"]) 
 					{
						var tipo = 'tkstring';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}
([\'][^']*[\']) 
 					{
						var tipo = 'tkstring2';
						var data = [yylloc.first_line, yylloc.first_column,tipo,yytext];
						addToken(data);
						return tipo;      
					}

//[\"]([^\"\n]|(\\\"))*[\"]       { console.log('Reconocion Cadena xd');  return 'tkstring';      }



<<EOF>>				return 'EOF';
.					{ 
						
						var data = [yylloc.first_line, yylloc.first_column, yytext,0];
						addErr(data); 
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
		$$ = new Nodo("INI","");
		$$.add($1);
		return {
					ast:$$,
					errores:LError,
					tokens:LToken
				}
	}
;

MAIN
	:rpublic rstatic rvoid rmain sparizq rstring rargs sparder STATCOR
	{
		$$ = new Nodo("MAIN","");
		$$.add($9);
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
	: MODIFICADOR CLASE_INTERFACE tkidentificador sllaveizq INS_CLASE sllaveder 
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

INS_CLASE
	:INS_CLASE DECLARA_ASIGN 
	{
		$1.add($2);
		$$ = $1;
	}
	|DECLARA_ASIGN
	{
		$$ = new Nodo("INS_CLASE","");
		$$.add($1);
	}
	|INS_CLASE LLAMADA_FUNCION 
	{
		$1.add($2);
		$$ = $1;
	}
	|LLAMADA_FUNCION
	{
		$$ = new Nodo("INS_CLASE","");
		$$.add($1);
	}
	|INS_CLASE IMP_METODO
	{
		$1.add($2);
		$$ = $1;
	}
	|IMP_METODO
	{
		$$ = new Nodo("INS_CLASE","");
		$$.add($1);
	}
	|INS_CLASE MAIN
	{
		$1.add($2);
		$$ = $1;
	}
	|MAIN	
	{
		$$ = new Nodo("INS_CLASE","");
		$$.add($1);
	}
	|INS_CLASE DEC_METODO
	{
		$1.add($2);
		$$ = $1;
	}
	|DEC_METODO	
	{
		$$ = new Nodo("INS_CLASE","");
		 $$.add($1);
	}
	|INS_CLASE EXP_AUMENTO spuntocoma 
	{
		$1.add($2);
		$$ = $1;
	}
	|EXP_AUMENTO spuntocoma
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
;

BREAK_CONTINUE
	:rbreak spuntocoma
	{
		$$ = new Nodo("break","");
	}
	|rcontinue spuntocoma
	{
		$$ = new Nodo("continue","");
	}
;


RETORNO
	: rreturn EXP spuntocoma
	{
		$$ = new Nodo("RETORNO","");	
		$$.add(new Nodo($1,""));
		$$.add($2);
	}
;

PRINT
	:rprint sparizq EXP sparder spuntocoma
	{
		$$ = new Nodo("PRINT","");	
		$$.add(new Nodo("print",""));
		$$.add($3);
	}
	|rprintln sparizq EXP sparder spuntocoma
	{
		$$ = new Nodo("PRINT","");	
		$$.add(new Nodo("println",""));
		$$.add($3);
	}

;


DEC_METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS   spuntocoma
	{
		$$ = new Nodo("DEC_METODO","");
		$$.add($1);
		$$.add($2);
		$$.add(new Nodo($3,""));
		$$.add(new Nodo($4,""));
		$$.add($5);
		$$.add($6);
	}	
	|TIPO_DATO tkidentificador sparizq  PARAMETROS    spuntocoma
	{
		$$ = new Nodo("DEC_METODO","");
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add(new Nodo($3,""));
		$$.add($4);
	}	
	| rvoid tkidentificador sparizq  PARAMETROS  spuntocoma
	{
		$$ = new Nodo("DEC_METODO","");
		$$.add(new Nodo($1,""));
		$$.add(new Nodo($2,""));
		$$.add($4);
	}
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS  spuntocoma
	{
		$$ = new Nodo("DEC_METODO","");
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add(new Nodo($3,""));
		$$.add($5);
	}
	|error
	{
		var data = [this._$.first_line,this._$.first_column,yytext,1];
		addErr(data); 

		$$ = new Nodo("ERROR","");
		$$.add(new Nodo(yytext,""));
	}
;

IMP_METODO
	:MODIFICADOR TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
		$$ = new Nodo("IMP_METODO","");
		$$.add($1);
		$$.add($2);
		$$.add(new Nodo($3,""));
		$$.add(new Nodo($4,""));
		$$.add($5);
		$$.add($6);
	}	
	|TIPO_DATO tkidentificador sparizq  PARAMETROS STATCOR
	{
		$$ = new Nodo("IMP_METODO","");
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add(new Nodo($3,""));
		$$.add($4);
		$$.add($5);
	}	
	| rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
		$$ = new Nodo("IMP_METODO","");
		$$.add(new Nodo($1,""));
		$$.add(new Nodo($2,""));
		$$.add(new Nodo($3,""));
		$$.add($4);
		$$.add($5);
	 }
	|MODIFICADOR rvoid tkidentificador sparizq  PARAMETROS STATCOR
	{
		$$ = new Nodo("IMP_METODO","");
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
	:LI DECLARA_ASIGN 				
	{
		$1.add($2);
		$$ = $1;
	}
	|DECLARA_ASIGN
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI LLAMADA_FUNCION 
	{
		$1.add($2);
		$$ = $1;
	}
	|LLAMADA_FUNCION
	{
		$$ = new Nodo("INS_CLASE","");
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
	|LI RETORNO
	{
		$1.add($2);
		$$ = $1;
	}
	|RETORNO
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI PRINT
	{
		$1.add($2);
		$$ = $1;
	}
	|PRINT
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI BREAK_CONTINUE
	{
		$1.add($2);
		$$ = $1;
	}
	|BREAK_CONTINUE
	{
		$$ = new Nodo("LI","");
		$$.add($1);
	}
	|LI EXP_AUMENTO spuntocoma 
	{
		$1.add($2);
		$$ = $1;
	}
	|EXP_AUMENTO spuntocoma
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
	:rfor sparizq  DECLARA_ASIGN EXP spuntocoma EXP_AUMENTO sparder  STATCOR 
	{
		$$ = new Nodo("FOR","");
		$$.add($3);
		$$.add($4);
		$$.add($6);
		$$.add($8);
	}
	|rwhile sparizq EXP sparder  STATCOR 
	{
		$$ = new Nodo("WHILE","");
		$$.add($3);
		$$.add($5);
	}
	|rdo  STATCOR  rwhile sparizq EXP sparder spuntocoma
	{
		$$ = new Nodo("DO_WHILE","");
		$$.add($2);
		$$.add($5);
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

IF  
	: rif sparizq EXP sparder  STATCOR  OTHERELSE
	{
		$$ = new Nodo("IF","");
		$$.add($3);
		$$.add($5);
		$$.add($6);
	}
    | rif sparizq EXP sparder STATCOR 
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
		$$.add(new Nodo($2,""));
		$$.add($3);
	}
    |         relse STATCOR	
	{
		$$ = new Nodo("OTHERELSE","");
		$$.add(new Nodo($1,""));
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
	: relse rif sparizq EXP sparder  STATCOR	
	{
		$$ = new Nodo("ELSEIF");
		$$.add($4);
		$$.add($6);
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
	|error sllaveder
	{
		var data = [this._$.first_line,this._$.first_column,yytext,1];
		addErr(data); 

		$$ = new Nodo("ERROR","");
		$$.add(new Nodo(yytext,""));
	}
;

LLAMADA_FUNCION
	:tkidentificador sparizq   LISTA_VALOR_PARAMETRO sparder spuntocoma 
	{
		$$ = new Nodo("LLAMADA_FUNCION","");
		$$.add(new Nodo($1,""));
		$$.add($3);
	}
;

LISTA_VALOR_PARAMETRO
	: LISTA_VALOR_PARAMETRO scoma EXP
	{
		$1.add($3);
		$$=$1;			
	}
	| EXP
	{
		$$ = new Nodo("LISTA_VALOR_PARAMETRO","");
		$$.add($1);
	}
;	

DECLARA_ASIGN
	: TIPO_DATO LISTA_ID  spuntocoma
	{
		$$ = new Nodo("DECLARACION","");
		$$.add($1);
		$$.add($2);
	}
	|LISTA_ID   spuntocoma
	{
		$$ = new Nodo("ASIGNACION","");
		$$.add($1);
	}
	|error spuntocoma
	{
		var data = [this._$.first_line,this._$.first_column,yytext];
		addErr(data); 

		$$ = new Nodo("ERROR","");
		$$.add(new Nodo(yytext,""));
	}

;

LISTA_ID
	: LISTA_ID scoma ID_IGUAL_EXP
	{
		$1.add($3);
		$$=$1;			
	}
	|ID_IGUAL_EXP
	{
		$$ = new Nodo("LISTA_ID","");
		$$.add($1);
	}
;

ID_IGUAL_EXP
	:tkidentificador sigual EXP
	{
		$$ = new Nodo("ID_IGUAL_EXP","");
		$$.add(new Nodo($1,""));
		$$.add($3);
	}
	|tkidentificador 
	{
		$$ = new Nodo("ID_IGUAL_EXP","");
		$$.add(new Nodo($1,""));
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

EXP
	: EXP sand EXP     
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	| EXP sor EXP 		
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	| EXP sxor EXP 		
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	| snot EXP							
	{
		$$ = new Nodo("EXP","")
		$$.add(new Nodo($1,""));
		$$.add($2);
	}	
	| EXP smayque EXP			
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	| EXP smenque EXP		
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	| EXP smayigque EXP	
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	|  EXP smenigque EXP	
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	| EXP sdobleig EXP			
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	|EXP snoig EXP			
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}	
	|smenos EXP %prec UMENOS 
	{
		$$ = new Nodo("EXP","")
		$$.add($2);
	}
	|EXP smas EXP
	{	
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}
	|EXP smenos EXP
	{	
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}
	|EXP spor EXP
	{	
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}
	|EXP sdiv EXP
	{	
		$$ = new Nodo("EXP","")
		$$.add($1);
		$$.add(new Nodo($2,""));
		$$.add($3);
	}
	|sparizq EXP sparder 
	{
		$$ = new Nodo("EXP","")
		$$.add($2);
	}
	|EXP_AUMENTO
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
	}
	| VALOR	
	{
		$$ = new Nodo("EXP","")
		$$.add($1);
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

VALOR 
	:tkstring
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}
	|tkstring2
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}
	| rfalse	
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}
	| rtrue		
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}
	|tkidentificador 
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}
	|tkflotante 
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}	
	|tkentero 
	{
		$$ = new Nodo("VALOR","")
		$$.add(new Nodo($1,""));
	}	
;

EXP_AUMENTO
	:tkidentificador  adicion
	{
		$$ = new Nodo("EXP_AUMENTO","");
		$$.add(new Nodo($1,""));
		$$.add(new Nodo($2,""));
	}
	|tkidentificador sustraccion
	{
		$$ = new Nodo("EXP_AUMENTO","");
		$$.add(new Nodo($1,""));
		$$.add(new Nodo($2,""));
	}
;