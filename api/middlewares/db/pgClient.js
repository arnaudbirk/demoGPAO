const debug = require('debug')('pgClient');
const Client = require('pg').Client;
const Pool = require('pg').Pool;

/*
 * middleware pour la création et la libération des connexions postgresql
 */
module.exports = async function(req, res, next) {
    debug("create pg connection...");
//TODO Voir comment utiliser les variables d'environnement pour la connection

    req.pgClient = new Client({
        user: process.env.PGUSER,
        host: process.env.PGHOST,
        database: process.env.PGDATABASE,
		password: process.env.PGPASSWORD,
        port: process.env.PGPORT
    });
    req.pgClient.connect();
    
    req.pgPool = new Pool({
        user: process.env.PGUSER,
        host: process.env.PGHOST,
        database: process.env.PGDATABASE,
        password: process.env.PGPASSWORD,
        port: process.env.PGPORT
    })
	
	debug("BEGIN")
	await req.pgPool.query('BEGIN');

    var _end = res.end; 
    res.end = function(){
        debug("close connection...");
        req.pgClient.end();
        _end.apply(this, arguments); 
    };
    next();
};

/*
PGUSER=dbuser \
PGHOST=database.server.com \
PGPASSWORD=secretpassword \
PGDATABASE=mydb \
PGPORT=3211 \
nodemon serveur.js
  */
