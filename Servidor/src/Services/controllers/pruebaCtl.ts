import { Request, Response } from 'express';
const parse = require('../../../build/ParserJavascript/Analisis/gramatica');

class Servicio {


    async prueba(req: Request, res: Response)
    {

        try {
            var result = parse.parse(req.body.texto);
            console.log(req.body);
            console.log(result)
            res.json({ responde: result });
            //res.json({ responde:req.body.texto});
        } catch (error) {
            console.log(error);    
        }

    }
    

}

export const servicio = new Servicio();