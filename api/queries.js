const Pool = require('pg').Pool
const pool = new Pool({
        user: process.env.PGUSER,
        host: process.env.PGHOST,
        database: process.env.PGDATABASE,
        password: process.env.PGPASSWORD,
        port: process.env.PGPORT
})

 const getFirstJobReady = (request, response) => {
    pool.query("select * from jobs where status='ready' limit 1", (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const insertJob = (request, response) => {
    const { command, status, log } = request.body
  
    pool.query('INSERT INTO jobs (command, status, log) VALUES ($1, $2, $3) RETURNING id', [command, status, log], (error, results) => {
      if (error) {
        throw error
      }
      response.status(201).send(`Job added with ID: ${results.rows[0].id}`)
    })
  }

  const updateJob = (request, response) => {
    const id = parseInt(request.params.id)
    const { status, log } = request.body
  
    pool.query(
      'UPDATE jobs SET status = $1, log = $2 WHERE id = $3',
      [status, log, id],
      (error, results) => {
        if (error) {
          throw error
        }
        response.status(200).send(`Job modified`)
      }
    )
  }

  module.exports = {
    getFirstJobReady,
    insertJob,
    updateJob,
  }
