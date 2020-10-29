import { Router } from 'express';

import { servicio } from '../controllers/pruebaCtl';

class UserRoutes{

    router: Router = Router();

    constructor(){
        this.config();
    }

    config(): void {
        this.router.post('/prueba',servicio.prueba);
        this.router.get('/prueba',servicio.prueba);
    }

}

const userRoutes = new UserRoutes();
export default userRoutes.router;
