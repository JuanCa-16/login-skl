//Conectarse a la BD
const {Pool} = require('pg'); 
// const {db} = require('./config.cjs'); //Archivo que contendra las variables

//LO PUSE ACA PORQUE YA ES EN LA NUBE SI ES COMO ANTES SE BORRA YA QUE LO CARGA EL REQUIRE COMENTADO DE ARRIBA
const {config} = require('dotenv') //Para ocultar credenciales
config(); //cargar valores de .env

const pool = new Pool({
    // user: db.user,
    // password: db.password,
    // host: db.host,
    // port: db.port,
    // database: db.database,
    connectionString: process.env.POSTGRES_URL,
})

module.exports = pool;