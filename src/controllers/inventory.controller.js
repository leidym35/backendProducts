const dbConnect = require('../../DataBase')
const controller = {}

controller.get = (req, res) => {
    let query = "exec ActionsInventory @actionType='select'"
    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json(rows.recordsets)
        }
        else {
            res.json("Error al consultar el inventario")
        }
    });
}

controller.post = (req, res) => {

    let query = "exec ActionsInventory @actionType='insert', @cant_inventory=" + req.body.cant_inventory+ ",@idReference=" + [req.body.idReference]

    console.log(query)
    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json("Inventario agregado")
        }
        else {
            res.json("Error agregando el inventario")
        }
    });
}

module.exports = controller;