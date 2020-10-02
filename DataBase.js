const config = require('./dbConfig');
const sql = require('mssql/msnodesqlv8')

const dbConnect = new sql.connect(config,
    function(err){
        if(err){
            console.log("Error al conectar BD", err)
        }
        else{
            console.log("Conectado a la BD", config.server)
        }
    }) 

module.exports = dbConnect