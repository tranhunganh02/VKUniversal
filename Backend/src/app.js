const compression = require("compression")
const express = require("express")
const { default: helmet } = require("helmet")
const morgan = require("morgan")

const app = express()

//init middlewares

app.use(morgan("common"))
app.use(helmet())
app.use(compression())

//init db

//init router

app.get('/', (req, res, next) => {
     const strCompress = 'Hello fanassa  gfdggg dad asdas'
     return res.status(200).json({
          message: 'Welcome casc!',
          metadata: strCompress.repeat(10000)
     })
})

//handling error

module.exports = app