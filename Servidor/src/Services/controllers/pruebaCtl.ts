import { Request, Response } from 'express';
import {TourTree} from '../../ParserJavascript/Interprete/TourTree';
import * as fs from 'fs';
const parse = require('../../../build/ParserJavascript/Analisis/gramatica');

class Servicio {


    Javascript(req: Request, res: Response)
    {

        try {
            
            //haciendo el parsing con jison
            var tree = parse.parse(req.body.texto);

            //recorriendo el arbol para crear el dot
            var tour:TourTree = new TourTree();
            var dot:string = tour.getDot(tree.ast);
            
            let err:String = tree.errores.reporteErrores();
            let consola:String = tree.errores.reportConsola();
            tree.errores.reiniciar();

            let reportToken:String =  tree.tokens.reporteTokens();
            tree.tokens.reiniciar();

            //creando el dot y ejecutando el codigo para generar el pdf
            fs.writeFile('codigo.dot',dot, (err)=>{ 
                if(err)throw err;
                tree.ast.execdot();
            });


            res.json({ 
                    responde: "true", 
                    errores: err,
                    consola:consola,
                    tokens:reportToken
                });

        } catch (error) {
            console.log(error);    
            res.json({ responde: "false" });
        }

    }
    

}

export const servicio = new Servicio();