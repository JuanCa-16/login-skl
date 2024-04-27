//URLs que el front va a utilizar para hacer peticiones
const {Router} = require('express');
const {getAllUsuarios, createUsuario, deleateUsuario, getUsuarioId, updateUsuarioId, verificarUsuario} = require('../controllers/sk.controller.cjs')
const router = Router();//Crear nuevas urls


//Obtener lista de usuarios
router.get('/usuarios', getAllUsuarios);

//OObtener 1 usuario por Id
router.get('/usuarios/:id', getUsuarioId);

//Crear un Usuario
router.post('/usuarios', createUsuario);

//Eliminar un Usuario
router.delete('/usuarios/:id', deleateUsuario);

//Actualizar un Usuario dado el id de este, se debe anexar un json con todo lo nuevo excepto el id
router.put('/usuarios/:id', updateUsuarioId);

//ruta para el login
router.post('/login', verificarUsuario);

module.exports = router;