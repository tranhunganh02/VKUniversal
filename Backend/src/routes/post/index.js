const express = require('express')
const postController = require('../../controller/post.controller')
const router = express.Router()
const { authenticationV2 } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler') 

//authentication
router.use(authenticationV2)

router.post('imagesTest', asyncHandler(postController.imageTest))
router.post('', asyncHandler(postController.createPost)) 
router.put('', asyncHandler(postController.updatePost)) 
router.delete('', asyncHandler(postController.deletePost)) 

module.exports = router
