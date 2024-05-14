const { updateStudent, updateDepartment, updateLecture, getUserInformationAndProfile, updateUserProfile } = require("../../dbs/user/pg.user");

const { BadRequestError } = require("../../core/error.response");
class UserService {

     //de update can truy thong tin cua bang ( student, lecture, apartment ) va role
     static async updateUser(user_id, payload) {

          const role = payload.role
          const student_id = payload.student_id

          delete payload.role;
          delete payload.student_id

          let updatedUser = null;

          if (role == 0) {
               updatedUser = updateStudent(user_id, student_id, payload)
          } else if(role == 1) {
               updatedUser = updateLecture(user_id, payload)
          }else if(role == 2) {
               updatedUser = updateDepartment(user_id, payload)
          }

          if(!updatedUser) new BadRequestError("cannot update")

     }
     static async updateProfile(user_id, payload) {

          console.log("vo day");

          const result = updateUserProfile(user_id, payload.bio)

          if(!result) new BadRequestError("cannot update")


     }
     static async getProfile(user_id, payload) {
          const result = getUserInformationAndProfile(user_id, payload.role)

          if(!result) new BadRequestError("Something went wrong")

          return result
     }

}

module.exports = UserService