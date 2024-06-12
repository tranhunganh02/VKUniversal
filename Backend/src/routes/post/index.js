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
//like post
router.post('/like', asyncHandler(postController.createLikePost))
router.delete('/like', asyncHandler(postController.UnLikePost))

router.get('', asyncHandler(postController.getPost))
router.get('/all', asyncHandler(postController.getAllPost)) 
router.get('/search', asyncHandler(postController.getPostsByField)) 
router.get('/follow', asyncHandler(postController.getPostFollowed)) 

//comment
router.get('/comment', asyncHandler(commentController.getCommentsById)) 
router.post('/comment', asyncHandler(commentController.createComment)) 
router.put('/comment', asyncHandler(commentController.updateComment)) 
router.delete('/comment', asyncHandler(commentController.deleteComment)) 

module.exports = router
