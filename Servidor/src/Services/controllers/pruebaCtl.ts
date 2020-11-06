import { Request, Response } from 'express';
import {TourTree} from '../../ParserJavascript/Interprete/TourTree';
import * as fs from 'fs';
import {Nodo} from '../../ParserJavascript/Interprete/Nodo'
const parse = require('../../../build/ParserJavascript/Analisis/gramatica');

class Servicio {


    prueba(req: Request, res: Response)
    {

        try {
            //haciendo el parsing con jison
            var tree = parse.parse(req.body.texto);
            console.log(req.body);
            console.log(tree);

            //recorriendo el arbol para crear el dot
            var tour:TourTree = new TourTree();
            var dot:string = tour.getDot(tree.ast);

            //creando el dot y ejecutando el codigo para generar el pdf
            fs.writeFile('codigo.dot',dot, (err)=>{ 
                if(err)throw err;
                tree.ast.execdot();
            });


            res.json({ responde: dot });
        } catch (error) {
            console.log(error);    
            res.json({ responde: "false" });
        }

    }
    

}

export const servicio = new Servicio();