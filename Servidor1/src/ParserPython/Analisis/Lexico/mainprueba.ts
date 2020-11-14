import {ID,TokenName} from './Constantes';
import { Token } from './Token';

class Server {

    constructor() {
    }


    start(): void {
        console.log(TokenName[ID.snegacion]);
    }

}

const server = new Server();
server.start();
