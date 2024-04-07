const express = require('express')

const router = express.Router()

//route main

//access route
router.use("/v1/api", require('./access'))

module.exports = router
