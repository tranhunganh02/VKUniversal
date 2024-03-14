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

module.exports = app