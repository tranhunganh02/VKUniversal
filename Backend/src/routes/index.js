const express = require('express')
const postController = require('../controller/post.controller')
const asyncHandler = require('../helper/asyncHandler')

const router = express.Router()

//route main

//access route
router.use("/v1/api/vkuniversal/", require('./access'))
router.use("/v1/api/vkuniversal/post/", require('./post'))
router.use("/v1/api/vkuniversal/test/", router.post(''), asyncHandler(postController.imageTest))
module.exports = router
