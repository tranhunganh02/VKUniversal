const express = require('express')
const postController = require('../../controller/post.controller')
const router = express.Router()
const { authenticationV2 } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler') 
const chatController = require('../../controller/chat.controller')


//authentication
router.use(authenticationV2)

router.get('/', asyncHandler(chatController.getChat)) 
router.post('/', asyncHandler(chatController.createRoomChat)) 

module.exports = router
