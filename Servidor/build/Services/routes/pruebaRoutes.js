"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const pruebaCtl_1 = require("../controllers/pruebaCtl");
class UserRoutes {
    constructor() {
        this.router = express_1.Router();
        this.config();
    }
    config() {
        this.router.post('/prueba', pruebaCtl_1.servicio.prueba);
        this.router.get('/prueba', pruebaCtl_1.servicio.prueba);
    }
}
const userRoutes = new UserRoutes();
exports.default = userRoutes.router;
