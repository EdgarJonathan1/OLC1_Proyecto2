export class Token{

    constructor(
        public linea:string,
        public columna:string,
        public tipo:string, //El nombre de la variable del token
        public descripcion:string,
        public id:number
    ){} 

}