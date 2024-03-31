//Create custom return success with appropriate HTTP status codes and messages
const {
     StatusCodes,
     ReasonPhrases
} = require('../utils/httpStatusCode')

// const StatusCode = {
//      OK: 200,
//      CREATED: 201
// }

// const ReasonStatusCode = {
//      OK: "Created",
//      CREATED: "Success"
// }

class SuccessResponse {

     constructor({message, statusCode = StatusCodes.OK, reasonStatusCode = ReasonPhrases.OK, metadata = {}}) {
         this.message = !message ? reasonStatusCode : message
         this.status = statusCode;
         this.metadata = metadata;         
     }

     send(res, header= {}) {
          return res.status(this.status).json(this)
     }

}

class OK extends SuccessResponse {

     constructor (message , metadata) {
          super({message, metadata})
     }
}

class CREATED extends SuccessResponse {

     constructor ({message, statusCode = StatusCodes.CREATED, reasonStatusCode = ReasonPhrases.CREATED, metadata}) {
          super({message, statusCode, reasonStatusCode, metadata})
     }
}

module.exports = {
     OK,
     CREATED,
     SuccessResponse
}