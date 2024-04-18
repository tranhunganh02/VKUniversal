const express = require('express')

const router = express.Router()

//route main

//access route
router.use("/v1/api/vkuniversal/", require('./access'))
router.use("/v1/api/vkuniversal/post/", require('./post'))
module.exports = router
