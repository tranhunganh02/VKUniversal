const compression = require("compression")
const express = require("express")
require('dotenv').config()
const { default: helmet } = require("helmet")
const morgan = require("morgan")

const app = express()

//init middlewares

app.use(morgan("dev"))
app.use(helmet())
app.use(compression())
app.use(express.json()); 

//init db
// Database and Firebase connections
require('./dbs/init.db.js');

//init router
app.use('/', require('./routes/index.js'))

//handling error

app.use((req, res, next) => { 
     const error = new Error('Not found');
     error.status = 404
     next(error)
})

app.use((error, req, res, next) => { 
     const statusCode = error.status || 500
     return res.status(statusCode).json({
          status: 'error',
          code: statusCode,
          message: error.message || 'Internal Server Error'
     })
     next(error)
})

module.exports = app