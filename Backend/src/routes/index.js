const express = require('express')

const router = express.Router()

//route main

//access route
router.use("/v1/api/vkuniversal/", require('./access'))
router.use("/v1/api/vkuniversal/post/", require('./post'))
router.use("/v1/api/vkuniversal/market/", require('./market'))
router.use("/v1/api/vkuniversal/user/", require('./user'))
module.exports = router
