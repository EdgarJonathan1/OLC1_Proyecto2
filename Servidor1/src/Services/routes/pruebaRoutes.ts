import { Router } from 'express';

import { servicio } from '../controllers/pruebaCtl';

class UserRoutes{

    router: Router = Router();
    
    constructor(){ this.config(); }

    config(): void {
        this.router.post('/Python',servicio.Python);
        this.router.post('/TraducirPython',servicio.TraducirPython);
        // this.router.get('/Javascript',servicio.Javascript);
        //this.router.get('/prueba',servicio.prueba);
    }

}

const userRoutes = new UserRoutes();
export default userRoutes.router;
