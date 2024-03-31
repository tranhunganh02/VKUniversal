const express = require('express')
const accessController = require('../../controller/access.controller')
const router = express.Router()
const  {asyncHandler} = require('../../auth/checkAuth')
//touter for login and signup
router.post('/vkuniversal/signup', asyncHandler(accessController.signUp)) 
router.post('/vkuniversal/login', asyncHandler(accessController.login)) 

module.exports = router
