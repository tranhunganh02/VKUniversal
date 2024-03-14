const express = require('express')
const accessController = require('../../controller/access.controller')
const router = express.Router()

//signUp
router.post('/vkuniversal/signup', accessController.signUp) 

module.exports = router
