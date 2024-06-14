const express = require('express')
const marketController = require('../../controller/market.controller')
const router = express.Router()
const { authentication, authenticationV2 } = require('../../auth/authUtils')
const asyncHandler = require('../../helper/asyncHandler')

//authentication
router.use(authenticationV2)

router.post('', asyncHandler(marketController.createMarket)) 
router.put('', asyncHandler(marketController.updateMarket)) 
router.delete('', asyncHandler(marketController.deleteMarket)) 
router.get('', asyncHandler(marketController.getMarketPost))
router.get('/all', asyncHandler(marketController.getAllMarketPost))

// //get category and product_type
// router.get('/', asyncHandler(marketController.getMarketPost))
module.exports = router
