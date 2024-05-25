// Funciones que usara routes, es para que se vea mas organizado 
const pool = require('../../database/db.cjs');
const bcrypt = require('bcrypt');
const jwtGenerator = require('../utils/jwtGenerator.cjs');
//---------------------------------------------
//MANEJO USUARIOS

//Obtener todos los usuarios
const getAllUsuarios = async (req,res) => {
    
    try {
        const allusuarios = await pool.query("SELECT * FROM usuario");
        res.json(allusuarios.rows); //Lado del cliente
    } catch (error) {
        console.log(error.message);
    }
}

//Obtener un usuario por ID
const getUsuarioId = async (req,res) => {

    try {
        const {id} = req.params;

        const result = await pool.query('SELECT * FROM usuario WHERE id = $1', [id]);

        if (result.rows.length === 0) return res.status(404).json({
            message: 'Usuario no Encontrado'
        }) 

        return res.json(result.rows[0]);
    } catch (error) {
        console.log(error.message)
    }
}

//Eliminar un usuario por ID
const deleateUsuario = async (req,res) => {
    
    const {id} = req.params;
    
    try {
        const result = await pool.query('DELETE FROM usuario WHERE id = $1 RETURNING *', [id]);

        if(result.rowCount === 0) return res.status(404).json({
            message: "usuario not found"
        });

        console.log(result.rows[0]);
        //return res.status(204);//estado de que funciono todo bien pero no devuelvo body no devuelvo nada
        return res.json({eliminado: "Empleado Eliminado"});
        //si despues lo quiero cambiar depronto es el sendStatus malo, solo es status
    } catch (error) {
        console.log(error.message)
    }
}

//------------------------------------------------
//ACTULIZAR PERFIL USUARIO

const updateUsuarioId = async (req,res) => {

    try {
        const {id} = req.params;
        const {nombre, apellidos, correo, clave, telefono, pais} = req.body; //Cuerpo de la peticion suele ser un json
        
        const email = await pool.query("SELECT * FROM usuario where correo = $1", [correo]);
        const antiguo = await pool.query("SELECT * FROM usuario where id = $1", [id]);
        
        if(email.rows.length !== 0 && (antiguo.rows[0].correo !== correo)){
            return res.status(401).json("Este correo ya se encuentra en uso");
        }

        //3. Bcrypt Contraseñá
        const saltRound = 10;
        const salt = await bcrypt.genSalt(saltRound);

        const bcryptClave = await bcrypt.hash(clave, salt);

        const result = await pool.query("UPDATE usuario SET nombre = $1, apellidos = $2, correo = $3, clave = $4, telefono = $5, pais = $6 WHERE id = $7 RETURNING *",[
                nombre, apellidos, correo, bcryptClave, telefono,pais, id,])
        
        //5. Generar el jwt token
        const token = jwtGenerator(result.rows[0].correo,result.rows[0].nombre);
        res.json({token});
        //console.log(id,rol, nombre, apellidos, correo, clave, telefono, fecha, pais, millas);
        //res.send('Actualizando un usuario ');
    } catch (error) {
        console.log(error.message)
    }
}
//------------------------------------------------
//PARA EL REGISTRO 

//Crear un usuario
const createUsuario = async (req,res) => {

    //1. Destructuracion
    const {id, rol, nombre, apellidos, correo, clave, telefono, fecha, pais} = req.body; //Cuerpo de la peticion suele ser un json
    
    try {

        //2. Verificar que el Id y correo no existan
        const user = await pool.query("SELECT * FROM usuario where id = $1", [id]);

        if(user.rows.length !== 0){
            return res.status(401).json("El usuario ya se encuentra registrado");
        }

        const email = await pool.query("SELECT * FROM usuario where correo = $1", [correo]);

        if(email.rows.length !== 0){
            return res.status(401).json("Este correo ya se encuentra en uso");
        }

        //3. Bcrypt Contraseñá
        const saltRound = 10;
        const salt = await bcrypt.genSalt(saltRound);

        const bcryptClave = await bcrypt.hash(clave, salt);

        //4. Agregar Usuario a la BD
        const result = await pool.query("INSERT INTO usuario (id,rol,nombre,apellidos,correo,clave,telefono,fecha,pais) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING *",[
            id, rol, nombre, apellidos, correo, bcryptClave, telefono, fecha, pais,
        ]); //Comando y luego arreglo con los valores que recibe del json del body de arriba

        //5. Generar el jwt token
        const token = jwtGenerator(result.rows[0].correo,result.rows[0].nombre);
        res.json({token});
        
    } catch (error) {
        //Pueden ser de tipo, que ya hay una primary key
        console.error(error.message);
        res.status(500).json(error.message); //Error del servidor
    }

}

//-------------------------------------------------
//LOGIN y NAVBAR (CUANDO INICIA SESION)

//ruta para el login
const verificarUsuario = async(req,res) => {

    //1. Destrucutrar
    const {correo, clave} = req.body;

    try {

        //2. Verificar si el usuario no existe
        const user = await pool.query("SELECT * FROM usuario where correo = $1", [correo]);

        if(user.rows.length === 0){
            return res.status(401).json("Usuario no registrado");
        }

        //3. Verificar Clave
        const validPassword = await bcrypt.compare(clave, user.rows[0].clave);

        if(!validPassword){
            return res.status(401).json("Contraseña incorrecta")
        }

        //res.json("ACCESSO PERMITIDO")

        //4. responder con jwt token
        const token = jwtGenerator(user.rows[0].correo,user.rows[0].nombre);
        res.json({llave: token, rol: user.rows[0].rol});
        
    } catch (error) {
        console.error(error.message);
        res.status(500).json(error.message); //Error del servidor
    }
}

//Verificar que esta autenticado - Para utenticar inicio de sesion
const isAutenticado = async (req,res) =>{

    //Aca en si la verificacon la hizo el Middleware, si llego a este punto es porque
    //si esta autenticado, por eso se retorna el True
    try {
        res.json(true)
    } catch (error) {
        console.error(error.message);
        res.status(500).json(error.message); //Error del servidor
    }
}

//accesoRestringido - Obtener el nombre en la navBar tras el middleware
const getUsuaLog = async (req,res) =>{
    try {

        const result = await pool.query('SELECT nombre, apellidos, id FROM usuario WHERE correo = $1', [req.correo]);
        res.json(result.rows[0]);

    } catch (err) {

        console.error(err.message)
        res.status(500).send("Error Servidor")

    }
}

//----------------------------------------------------
//AEROPUERTOS y VUELOS

//Obtener todos los aeropuertos
const getAllAero = async (req,res) => {
    
    try {
        const aerepuertos = await pool.query("SELECT * FROM aeropuerto");
        res.json(aerepuertos.rows); //Lado del cliente
    } catch (error) {
        console.log(error.message);
    }
}

const getVueloBuscado = async(req,res) =>{
    try {

        const {aeropuertoSalida, aeropuertoLlegada, fecha} = req.body;
        
        const result = await pool.query('SELECT v.id_Avion, v.id_Vuelo, v.estado, v.hora, v.fecha, l.Id_Aeropuerto AS id_Aeropuerto_Llegada, l.Pais AS pais_llegada, l.Nombre AS nombre_aeropuerto_llegada, l.Ciudad AS ciudad_llegada, s.Id_Aeropuerto AS id_Aeropuerto_Salida, s.Pais AS pais_salida, s.Nombre AS nombre_aeropuerto_salida, s.Ciudad AS ciudad_salida FROM VUELO v JOIN AEROPUERTO l ON v.aeropuertoLlegada = l.Id_Aeropuerto JOIN AEROPUERTO s ON v.aeropuertoSalida = s.Id_Aeropuerto WHERE s.Id_Aeropuerto = $1 AND l.Id_Aeropuerto= $2 AND v.fecha = $3', [aeropuertoSalida, aeropuertoLlegada, fecha]);
        if (result.rows.length === 0) return res.status(404).json({
            message: 'NO hay vuelos'
        }) 
        return res.json(result.rows);
    } catch (error) {
        console.log(error.message)
    }
}

const getVuelosAsignados = async (req, res) => {
    try {
        const {id} = req.params;
        const userId = id;
        
        const query = `SELECT V.id_vuelo,V.id_avion,V.estado,V.hora,V.fecha,A1.nombre AS aeropuertosalida,A2.nombre AS aeropuertollegada FROM public.vuelo V JOIN public.administrar A ON V.id_vuelo = A.id_vuelo JOIN public.usuario U ON A.id_usuario = U.id JOIN public.aeropuerto A1 ON V.aeropuertosalida = A1.id_aeropuerto JOIN public.aeropuerto A2 ON V.aeropuertollegada = A2.id_aeropuerto WHERE U.id = $1;`;
        
        const result = await pool.query(query, [userId]);
        if (result.rows.length === 0) {
            return res.status(404).json({
                message: 'No hay vuelos :)'
            });
        }
        
        return res.json(result.rows);
    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            message: 'Error interno del servidor'
        });
    }
}


//-----------------------------------------------------
//ASIENTOS
const getAsientosVuelo = async (req,res) => {
    
    try {
        const {vuelo} = req.params;
        const asientos = await pool.query("SELECT numero_asiento FROM asiento a WHERE a.vuelo = $1 AND a.estado = 'Ocupado'",[vuelo]);
        res.json(asientos.rows); //Lado del cliente
    } catch (error) {
        console.log(error.message);
    }
}

const actualizarAsiento = async (req, res) => {
    try {
        const { asientos, idVuelo } = req.body;

        for (const asiento of asientos) {
            await pool.query("UPDATE asiento SET estado ='Ocupado' WHERE numero_asiento = $1 AND vuelo = $2", [asiento, idVuelo]);
        }

        res.json({ message: 'Estados de los asientos actualizados correctamente.' });
    } catch (error) {
        console.log(error.message);
        res.status(500).json({ error: 'Error actualizando los asientos' });
    }
};

const updateMillas = async (req, res) => {
    try {
        const { id } = req.params;
        
        // Ejecutar la consulta para obtener las millas actuales del usuario
        const result = await pool.query("SELECT millas FROM usuario WHERE id = $1", [id]);
        
        // Verificar si el usuario fue encontrado
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        }

        // Obtener las millas antiguas
        const millasAntiguas = result.rows[0].millas;

        // Sumar las nuevas millas
        const millas = millasAntiguas + 100;

        // Actualizar las millas del usuario en la base de datos
        const updateResult = await pool.query("UPDATE usuario SET millas = $1 WHERE id = $2 RETURNING millas", [millas, id]);

        // Enviar una respuesta JSON con el usuario actualizado
        res.json({ message: 'Sumas 100 Millas ahora tienes: ', usuario: updateResult.rows[0] });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Error actualizando las millas' });
    }
};


module.exports = {
    getAllUsuarios,
    getUsuarioId,
    createUsuario,
    deleateUsuario,
    updateUsuarioId,
    verificarUsuario,
    isAutenticado,
    getUsuaLog,
    getAllAero,
    getVueloBuscado,
    getVuelosAsignados,
    getAsientosVuelo,
    actualizarAsiento,
    updateMillas
}