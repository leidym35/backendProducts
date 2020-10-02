const express = require('express');
const router = express.Router()
const ProductosController= require('../controllers/productos.controller') 

router.post('/addProducto',ProductosController.post) 
router.get('/productos',ProductosController.get)
router.get('/productos/:id',ProductosController.getById)
router.put('/productoUpdate/:id',ProductosController.update)
router.delete('/productoUpdate/:id',ProductosController.delete)

module.exports = router