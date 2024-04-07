const express = require('express')
const accessController = require('../../controller/access.controller')
const router = express.Router()
const { authentication } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler')
//touter for login and signup
router.post('/vkuniversal/signup', asyncHandler(accessController.signUp)) 
router.post('/vkuniversal/login', asyncHandler(accessController.login)) 

//authentication
router.use(authentication)

router.post('/vkuniversal/logout', asyncHandler(accessController.logout)) 
router.post('/vkuniversal/handlerRefreshToken', asyncHandler(accessController.handlerRefreshToken)) 

module.exports = router
