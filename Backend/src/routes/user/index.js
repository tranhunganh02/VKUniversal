const express = require('express')
const router = express.Router()
const { authenticationV2 } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler') 
const userController = require('../../controller/user.controller')


//authentication
router.use(authenticationV2)


router.put('', asyncHandler(userController.updateUser)) 

router.put('/profile', asyncHandler(userController.updateUserProfile))
router.get('/profile', asyncHandler(userController.getUserProfile)) 

router.get('/checkStudent', asyncHandler(userController.checkStudentExist)) 

router.post('/follow',asyncHandler(userController.createFollow))
router.delete('/follow',asyncHandler(userController.unFollow))
module.exports = router
