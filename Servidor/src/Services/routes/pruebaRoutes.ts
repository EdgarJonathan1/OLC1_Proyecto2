import { Router } from 'express';

import { servicio } from '../controllers/pruebaCtl';

class UserRoutes{

    router: Router = Router();

    constructor(){
        this.config();
    }

    config(): void {
        this.router.post('/Javascript',servicio.Javascript);
        this.router.post('/traducirJavascript',servicio.TraducirJavascript);
       // this.router.get('/Javascript',servicio.Javascript);
        //this.router.get('/prueba',servicio.prueba);
    }

}

const userRoutes = new UserRoutes();
export default userRoutes.router;
