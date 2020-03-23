const router = require('express').Router()
const pgClient = require('./../../middlewares/db/pgClient')
const jobs = require('./../../middlewares/jobs')

//router.get('/job/ready', pgClient, jobs.getFirstJobReady)
router.get('/jobs', jobs.getAllJobs)
//router.post('/jobs', pgClient /*db.insertJob*/)
//router.put('/jobs/:id', pgClient /*db.updateJob*/)

module.exports = router
