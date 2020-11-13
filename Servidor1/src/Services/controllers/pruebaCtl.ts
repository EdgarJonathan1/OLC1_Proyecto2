import { Request, Response } from 'express';
import {TourTree} from '../../ParserJavascript/Interprete/TourTree';
import * as fs from 'fs';

class Servicio {


    Javascript(req: Request, res: Response)
    {
        try {
            
            res.json({ 
                    responde: "true" 
                });

        } catch (error) {
            console.log(error);    
            res.json({responde:"false"});
        }
    }
    
    TraducirJavascript(req: Request, res: Response)
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