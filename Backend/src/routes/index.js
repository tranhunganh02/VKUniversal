const express = require('express')

const router = express.Router()

router.use("/v1/api", require('./access'))

// router.get('', (req, res, next) => {
//      const strCompress = 'Hello fanassa  gfdggg dad asdas'
//      return res.status(200).json({
//           message: 'Welcome casc!',
//           metadata: strCompress.repeat(1)
//      })
// })

module.exports = router
