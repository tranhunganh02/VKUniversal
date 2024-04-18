const express = require('express')
const postController = require('../../controller/post.controller')
const router = express.Router()
const { authenticationV2 } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler') 
const commentController = require('../../controller/comment.controller')


//authentication
router.use(authenticationV2)

//post
router.put('/attachment', (postController.updatePostAttachment)) 
router.post('', asyncHandler(postController.createPost)) 
router.put('', asyncHandler(postController.updatePost)) 
router.delete('', asyncHandler(postController.deletePost)) 

//comment
router.post('/comment', asyncHandler(commentController.createComment)) 

module.exports = router
