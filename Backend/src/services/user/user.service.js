const {
  updateStudent,
  updateDepartment,
  updateLecture,
  getUserInformationAndProfile,
  updateUserProfile,
} = require("../../dbs/user/pg.user");

const { BadRequestError } = require("../../core/error.response");
class UserService {
  //de update can truy thong tin cua bang ( student, lecture, apartment ) va role
  static async updateUser(user_id, role, payload) {
    //cac truong bat buoc la role
    if (role != payload.role) {
          new BadRequestError("cannot update");
    }
    delete payload.role;

    let updatedUser = null;

    console.log("role", role);

    if (role == 1) {
      const student_id = payload.student_id;
      delete payload.student_id;
      updatedUser = await updateStudent(user_id, student_id, payload);
    } else if (role == 2) {
      const lecture_id = payload.lecture_id;
      delete payload.lecture_id;
      updatedUser = await updateLecture(user_id, lecture_id, payload);
    } else if (role == 3) {
      const department_id = payload.department_id;
      delete payload.department_id;
      updatedUser = await updateDepartment(user_id, department_id, payload);
    }

    console.log("result:", updatedUser);
    if (!updatedUser) throw new BadRequestError("cannot update");
  }
  //update vao profile
  static async updateProfile(user_id, payload) {
    console.log("vo day");

    const result = updateUserProfile(user_id, payload.bio);

    if (!result)throw new BadRequestError("cannot update");
  }
  static async getProfile(user_id, role) {
    console.log("id", user_id);
    const { user_bio, user } = await getUserInformationAndProfile(user_id, role);

    console.log("result", user_bio, user);

    if (!user_bio || !user) throw new BadRequestError("Something went wrong");

    return {
      user_bio: user_bio ? user_bio.bio : null, 
        user: user
    };

}

  static async createStudent(user_id) {
    const result = getUserInformationAndProfile(user_id, payload.role);

    if (!result)throw new BadRequestError("Something went wrong");

    return result;
  }
}

module.exports = UserService;
