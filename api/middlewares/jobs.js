const Pool = require('pg').Pool
const pool = new Pool({
        user: process.env.PGUSER,
        host: process.env.PGHOST,
        database: process.env.PGDATABASE,
        password: process.env.PGPASSWORD,
        port: process.env.PGPORT
})

function getAllJobs(req, res, next){
	pool.query("SELECT * FROM jobs", (error, results) => {

	if (error) {
		throw error
	}

	res.status(200).json(results.rows)
	})
}


/*function getAllJobs(req, res, next){
	var sql = "SELECT * FROM jobs"
	console.log(sql)

	try{
		var result = req.pgPool.query(sql)
	}catch (err){
		console.log(err)
		throw {
			code: 500,
			msg: {
				status: 'Erreur systeme',
				errors: [{ "msg": err.message}]
			}
		}
	}

	console.log(result.rows)

	var prList = result.rows.map(function(row) {response.status(200).json(results.rows)
                        return row;
		})

	if (!req.resultat){
		req.resultat={}
	}
                req.resultat["jobs"] = result.rows

	next()
}*/

module.exports = {
	getAllJobs
//	getJobReady
}
