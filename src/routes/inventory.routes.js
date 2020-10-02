const express = require('express');
const router = express.Router()
const inventoryController= require('../controllers/inventory.controller') 

router.post('/addInventario',inventoryController.post) 
router.get('/inventario',inventoryController.get)


module.exports = router