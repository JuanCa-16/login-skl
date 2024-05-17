//URLs que el front va a utilizar para hacer peticiones
const {Router} = require('express');
const {getAllUsuarios, createUsuario, deleateUsuario, getUsuarioId, updateUsuarioId, verificarUsuario, isAutenticado, getUsuaLog, getAllAero, getVueloBuscado} = require('../controllers/sk.controller.cjs')
const router = Router();//Crear nuevas urls
const auth = require('../middleware/autorizacion.cjs');

//-------------------------------------
//USUARIOS

//Obtener lista de usuarios
router.get('/usuarios', getAllUsuarios);

//Obtener un usuario por Id
router.get('/usuarios/:id', getUsuarioId);

//Eliminar un Usuario
router.delete('/usuarios/:id', deleateUsuario);

//--------------------------------------
//ACTUALIZAR PERFIL USUARIO

//Actualizar un Usuario dado el id de este, se debe anexar un json con todo lo nuevo excepto el id
router.put('/usuarios/:id', updateUsuarioId);

//-------------------------------------
//REGISTRO

//Crear un Usuario
router.post('/usuarios', createUsuario);

//-------------------------------------
//LOGIN y NAVBAR (CUANDO INICIA SESION)

//Ruta para el login
router.post('/login', verificarUsuario);

//Para utenticar inicio de sesion
router.get('/estalogin',auth,isAutenticado);

//Obtener el nombre en la navBar
router.get('/usuarioLogin',auth,getUsuaLog);

//--------------------------------------
//AEROPUERTOS

//Obtener Aeropuertos
router.get('/aeropuertos',getAllAero);

router.post('/vuelos', getVueloBuscado);
//---------------------------------------
module.exports = router;