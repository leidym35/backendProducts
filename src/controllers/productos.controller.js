const dbConnect = require('../../DataBase')
const controller = {}

controller.get = (req, res) => {
    let query = "exec ActionsProducts @actionType='select'"
    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json(rows.recordsets)
        }
        else {
            res.json("Error al consultar la referencia")
        }
    });
}


controller.getById = (req, res) => {

    let query = "exec ActionsProducts @actionType='selectById', @idReference=" + [req.params.id]
    console.log(query)
    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json(rows.recordsets)
        }
        else {
            res.json("Error al consultar la referencia")
        }
    });
}

controller.post = (req, res) => {

    let query = "exec ActionsProducts @actionType='insert', @idReference=" + req.body.idReference + ", @reference='" + req.body.reference+
    "', @descriptionReference='" + req.body.descriptionReference+"', @colour='" + req.body.colour+"', @price=" + req.body.price

    console.log(query)
    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json("Se agrego con exito la referencia")
        }
        else {
            res.json("Error agregando referencia")
        }
    });
}

controller.update = (req, res) => {
    let query = "exec ActionsProducts @actionType='update', @idReference=" + req.params.id + ", @reference='" + req.body.reference+
    "', @descriptionReference='" + req.body.descriptionReference+"', @colour='" + req.body.colour+"', @price=" + req.body.price

    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json("Se actualizó con exito la referencia")
        }
        else {
            res.json("Error actualizando referencia")
        }
    });
}


controller.delete = (req, res) => {

    let query = "exec ActionsProducts @actionType='delete', @idReference=" + [req.params.id]
    console.log(query)
    dbConnect.query(query, (err, rows) => {
        if (!err) {
            res.json("Se a eliminado la referencia")
        }
        else {
            res.json("Error eliminando la referencia")
        }
    });
}

module.exports = controller;