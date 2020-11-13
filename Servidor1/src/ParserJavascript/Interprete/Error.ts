export class Error{

    constructor(
        public tipo:string,
        public linea:string,
        public columna:string,
        public descripcion:string,
    ){} 

}