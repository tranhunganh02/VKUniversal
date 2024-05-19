const express = require('express')
const accessController = require('../../controller/access.controller')
const router = express.Router()
const { authentication, authenticationV2 } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler')
//touter for login and signup
router.post('/signup', asyncHandler(accessController.signUp)) 
router.post('/login', asyncHandler(accessController.login)) 
router.post('/signupDepartment', asyncHandler(accessController.signUpDepartment)) 
//authentication
router.use(authenticationV2)

router.post('/logout', asyncHandler(accessController.logout)) 
router.post('/handlerRefreshToken', asyncHandler(accessController.handlerRefreshToken)) 

module.exports = router
