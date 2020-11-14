import { Request, Response } from 'express';
import {Lexico} from '../../ParserPython/Analisis/Lexico/Lexico';
import * as fs from 'fs';


class Servicio {


    Python(req: Request, res: Response)
    {
        try {

            let lex:Lexico = new Lexico();            
            lex.analizar(req.body.texto);

            let repToken:string = lex.tokens.reporteTokens();
            let repError:string = lex.errores.reporteErrores();

            // console.log(req.body.texto);
            res.json({ 
                    responde: "true",
                    tokens:repToken,
                    errores:repError
                });

        } catch (error) {
            console.log(error);    
            res.json({responde:"false"});
        }
    }
    
    TraducirPython(req: Request, res: Response)
    {
        try {
            res.json({ 
                    responde: "true" 
                });

        } catch (error) {
            
            console.log(error);    
            res.json({ responde: "false" });
        }

    }

}

export const servicio = new Servicio();