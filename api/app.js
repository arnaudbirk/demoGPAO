const express = require('express')
const bodyParser = require('body-parser')
const port = 3000

const db = require('./queries')

const app = express()

app.use(cors());
app.use(bodyParser.json());

app.use(function (req, res, next) {
	console.log("----------------------------")
	console.log(req.method, ' ', req.path, ' ', JSON.stringify(req.query))
        console.log("received at " + Date.now())
	next();
})

app.use('/api/vendor/swagger-editor', express.static(__dirname + '/node_modules/swagger-editor-dist'));
app.use('/api/vendor/swagger-ui', express.static(__dirname + '/node_modules/swagger-ui-dist'));
app.use('/api/doc', express.static(__dirname + '/../doc'));

app.get('/', (request, response) => {
  response.json({ info: 'Node.js, Express, and Postgres API' })
})

app.get('/jobs', db.getFirstJobReady)
app.post('/jobs', db.insertJob)
app.put('/jobs/:id', db.updateJob)

app.listen(port, function () {
  console.log('App running on port '+port)
})
