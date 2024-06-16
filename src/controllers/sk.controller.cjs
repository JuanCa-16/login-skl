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

//Crear un usuario
const createVuelo = async (req,res) => {

    //1. Destructuracion
    const {infoVuelo, listaEmp} = req.body; //Cuerpo de la peticion suele ser un json
    const {aeropuertoSalida,aeropuertoLlegada,fecha,hora,id, opcInicialSalida} = infoVuelo
    
    try {

        //Comprobaciones que no halla un id_avion en esa fecha
        const info = await pool.query("SELECT id_Vuelo FROM vuelo WHERE fecha = $1 AND id_avion = $2", [fecha,id]);
        if(info.rows.length !== 0){
            return res.status(401).json("El avion ya tiene un vuelo ese dia");
        }

        const id_result = await pool.query("SELECT id_Vuelo FROM vuelo ORDER BY id_Vuelo DESC LIMIT 1;", []);
        let id_nuevo = (id_result.rows[0].id_vuelo) + 1

        const id_asiento = await pool.query("SELECT Id_Asiento FROM asiento ORDER BY Id_Asiento DESC LIMIT 1;", []);
        let id_nuevo_asiento = (id_asiento.rows[0].id_asiento) + 1

        
        const result = await pool.query("INSERT INTO vuelo (id_Vuelo, id_Avion, estado, hora, fecha, aeropuertoLlegada, aeropuertoSalida) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *",[
            id_nuevo, id, 'Programado', hora, fecha, aeropuertoLlegada, aeropuertoSalida
        ]);

        // Insertar los asientos para el vuelo recién insertado
        // Genera 60 filas de datos
        for (let i = 1; i <= 60; i++) {
            // Calcula el número de fila (entre 0 y 9)
            const fila = Math.floor((i - 1) / 6);
            // Calcula el número de columna (entre 0 y 5)
            const columna = (i - 1) % 6;
            // Calcula el número de asiento (en el formato 'fila-columna')
            const numero_asiento = fila + '-' + columna;

            // Inserta el asiento en la tabla ASIENTO
            await pool.query("INSERT INTO asiento (Id_Asiento, Numero_Asiento, Estado, Vuelo) VALUES ($1, $2, $3, $4)", [
                id_nuevo_asiento, numero_asiento, 'Disponible', id_nuevo
            ]);

            console.log("Asiento insertado:", numero_asiento);
            id_nuevo_asiento = id_nuevo_asiento + 1
        }


        for (const emp of listaEmp) {
            let id_emp = emp.value
            const respuesta = await pool.query("INSERT INTO administrar (Id_Usuario, Id_Vuelo) VALUES ($1,$2) RETURNING *",[
                id_emp, id_nuevo]);
            
            console.log(respuesta.rows)
        }

        res.json({ message: 'Vuelo creado Exitosamente' });
        
    } catch (error) {
        //Pueden ser de tipo, que ya hay una primary key
        console.error(error.message);
        res.status(500).json(error.message); //Error del servidor
    }

}

const obtenerTiquets = async (req,res) => {
    
    const { id } = req.params;
    try {
        const result = await pool.query("SELECT TIQUETE.Id_Tiquete, TIQUETE.Asientos, TIQUETE.Clase, TIQUETE.Precio, VUELO.id_Avion, VUELO.id_Vuelo, VUELO.fecha, VUELO.hora, LLEGADA.Nombre AS Aeropuerto_Llegada, SALIDA.Nombre AS Aeropuerto_Salida, USUARIO.id AS Id_Usuario, EQUIPAJE.Maleta, COMIDA.Nombre AS Comida_Nombre FROM TIQUETE JOIN VUELO ON TIQUETE.Id_Vuelo = VUELO.id_Vuelo JOIN USUARIO ON TIQUETE.Id_Usuario = USUARIO.id JOIN AEROPUERTO AS LLEGADA ON VUELO.aeropuertoLlegada = LLEGADA.Id_Aeropuerto JOIN AEROPUERTO AS SALIDA ON VUELO.aeropuertoSalida = SALIDA.Id_Aeropuerto JOIN EQUIPAJE ON EQUIPAJE.Id_TiqueteV = TIQUETE.Id_Tiquete JOIN COMIDA ON COMIDA.Id_TiqueteV = TIQUETE.Id_Tiquete WHERE USUARIO.id = $1", [id]);


        res.json(result.rows); 
        
    } catch (error) {
        // Manejo de errores
    }
}

const createPase = async (req, res) => {
    const { precio, id_vuelo, id_usuario, asientos, clase, comida, maleta } = req.body; // Cuerpo de la petición suele ser un JSON
    const asientosCadena = asientos.join(',');

    try {
        // Insertar en la tabla tiquete y obtener el Id_Tiquete insertado
        const result = await pool.query(
            "INSERT INTO tiquete (Metodo_de_pago, Asientos, Clase, Precio, Id_Vuelo, Id_Usuario) VALUES ($1, $2, $3, $4, $5, $6) RETURNING Id_Tiquete",
            ["Debito", asientosCadena, clase, precio, id_vuelo, id_usuario]
        );

        const idTiquete = result.rows[0].id_tiquete;

        // Insertar en la tabla comida usando el Id_Tiquete obtenido
        await pool.query(
            "INSERT INTO comida (Nombre, Id_tiqueteV) VALUES ($1, $2) RETURNING *",
            [comida, idTiquete]
        );

        // Insertar en la tabla equipaje usando el Id_Tiquete obtenido
        await pool.query(
            "INSERT INTO equipaje (Maleta, Id_tiqueteV) VALUES ($1, $2) RETURNING *",
            [maleta, idTiquete]
        );

        res.json({ message: 'Vuelo Guardado' });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};



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
    updateMillas,
    createVuelo,
    createPase,
    obtenerTiquets
}