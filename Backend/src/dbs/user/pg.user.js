const db = require("../init.db.js");

// Get a student by student_id
const getStudentById = async (studentId) => {
  const query = `
    SELECT * FROM Student WHERE student_id = $1;
  `;
  const values = [studentId];
  const result = await db.query(query, values);
  return result[0];
};

// Update student information
const updateStudent = async (userId, updates) => {
  console.log(`id: ${userId}`);
  console.log("data,", updates);
  let query = "UPDATE student SET ";
  let values = [];
  let updateFields = Object.keys(updates);
  let setClause = "";

  // Xây dựng phần SET của câu lệnh SQL dựa trên các trường cần cập nhật
  updateFields.forEach((field, index) => {
    setClause += `${field} = $${index + 1}, `;
    values.push(updates[field]);
  });

  // Loại bỏ dấu phẩy cuối cùng từ phần SET và thêm điều kiện WHERE
  setClause = setClause.slice(0, -2);

  // Thêm phần SET vào câu lệnh UPDATE
  query += setClause;

  // Thêm điều kiện WHERE
  query += ` WHERE user_id = $${updateFields.length + 1} RETURNING *;`;

  // Thêm giá trị studentId và userId vào mảng values
  values.push(userId);

  console.log(query);
  console.log(values);

  const result = await db.query(query, values);

  console.log("result", result);
  return result[0];
};

// Assuming you have already initialized your database connection as 'db'

// Update lecture information
const updateLecture = async (lectureId, updates) => {
  let query = "UPDATE Lecturer SET ";
  const values = [];
  const updateFields = Object.keys(updates);
  let setClause = "";

  // Xây dựng phần SET của câu lệnh SQL dựa trên các trường cần cập nhật
  updateFields.forEach((field, index) => {
    setClause += `${field} = $${index + 1}, `;
    values.push(updates[field]);
  });

  // Loại bỏ dấu phẩy cuối cùng từ phần SET và thêm điều kiện WHERE
  setClause = setClause.slice(0, -2);
  query +=
    setClause + ` WHERE lecturer_id = $${updateFields.length + 1} RETURNING *;`;

  // Thêm giá trị lectureId vào cuối mảng values
  values.push(lectureId);

  const result = await db.query(query, values);
  return result[0];
};

// Update department information
const updateDepartment = async (departmentId, updates) => {
  let query = "UPDATE Department SET ";
  const values = [];
  const updateFields = Object.keys(updates);
  let setClause = "";

  // Xây dựng phần SET của câu lệnh SQL dựa trên các trường cần cập nhật
  updateFields.forEach((field, index) => {
    setClause += `${field} = $${index + 1}, `;
    values.push(updates[field]);
  });

  // Loại bỏ dấu phẩy cuối cùng từ phần SET và thêm điều kiện WHERE
  setClause = setClause.slice(0, -2);
  query +=
    setClause +
    ` WHERE department_id = $${updateFields.length + 1} RETURNING *;`;

  // Thêm giá trị departmentId vào cuối mảng values
  values.push(departmentId);

  const result = await db.query(query, values);
  return result[0];
};

// Delete a student by student_id
const deleteStudent = async (studentId) => {
  const query = `
    DELETE FROM Student WHERE student_id = $1 RETURNING *;
  `;
  const values = [studentId];
  await db.query(query, values);
};

const updateUserProfile = async (user_id, bio) => {
  console.log("dad", bio);
  let query = "UPDATE user_profile SET bio = $1 where user_id = $2 RETURNING *";
  const values = [bio, user_id];
  const result = await db.query(query, values);
  return result[0];
};
const getUserInformationAndProfile = async (user_id, role) => {
  console.log("in db", user_id, role);
  const query = "SELECT bio from user_profile WHERE user_id = $1 ;";
  const values = [user_id];
  const result = await db.query(query, values);

  let query2 = null;
  if (role == 1) {
    query2 = `
    SELECT
        s.user_id,
        s.student_code,
        s.surname,
        s.last_name,
        s.date_of_birth,
        s.gender,
        uc.class_id,
        uc.class_name,
        m.major_id,
        m.major_name,
        u.email,
        u.avatar
    FROM
        student s
      LEFT JOIN 
        university_class uc ON s.class_id = uc.class_id
      LEFT JOIN 
        major m ON uc.major_id = m.major_id
      LEFT JOIN 
        users u ON s.user_id = u.user_id
    WHERE
        s.user_id = $1;
  `;
  } else if (role == 2) {
    query2 = `
    SELECT 
    jsonb_build_object('ar_id',a.ar_id, 'ar_name', a.ar_name) AS acedemic_rank,
   jsonb_build_object('degree_id', d.degree_id, 'degree_name', d.degree_name) AS degree,
   jsonb_build_object('faculty_id', f.faculty_id, 'faculty_name', f.faculty_name) AS faculty,
   le.user_id,
   le.gender,
   le.surname,
   le.last_name,
   le.date_of_birth,
   u.email,
   u.avatar
FROM 
   lecturer le
LEFT JOIN 
   acedemic_rank a ON le.academic_id = a.ar_id
LEFT JOIN 
   degree d ON le.degree_id = d.degree_id
LEFT JOIN 
   faculty f ON le.faculty_id = f.faculty_id
LEFT JOIN 
   users u ON le.user_id = u.user_id
WHERE 
   le.user_id = $1;
  `;
  } else if (role == 3) {
    console.log("vo day");
    query2 = `
    SELECT 
      department_id,
      department_name,
      user_id
    FROM 
      department 
    WHERE
        user_id = $1;
  `;
  } else return false;

  const result2 = await db.query(query2, values);
  console.log("result", result2);

  return { user_bio: result[0], user: result2[0] };
};

const checkStudentExist = async (userId) => {
  console.log("vo day r");
  const query = `
  SELECT 1 FROM student WHERE user_id = $1 AND class_id IS NOT NULL;
  `;
  const values = [userId];
  const result = await db.query(query, values);
  console.log("result", result);

  console.log("dasd", result[0] == null ? "dell" : "co");
  if (result[0] == null) return false;

  return true;
};

const makeFollow = async (follower_id, followed_id) => {
  const query = `
  INSERT INTO follow (follower_id, followed_id) VALUES ($1, $2) returning *;
  `;
  const values = [follower_id, followed_id];
  const result = await db.query(query, values);
  return result[0];
};

const unFollow = async (follower_id, followed_id) => {
  const query = `
  DELETE FROM follow WHERE follower_id = $1 AND followed_id = $2 RETURNING *;
  `;
  const values = [follower_id, followed_id];
  const result = await db.query(query, values);

  if (result.length > 0) {
    return true;
  } else {
    return false;
  }
};

const getUserChat = async (userNumber) => {
  const query = `SELECT 
  u.user_id,
  u.avatar,
  CASE 
      WHEN u.role = 1 THEN s.surname
      WHEN u.role = 2 THEN l.surname
      ELSE NULL
  END AS surname,
  CASE 
      WHEN u.role = 1 THEN s.last_name
      WHEN u.role = 2 THEN l.last_name
      ELSE NULL
  END AS last_name,
  CASE 
      WHEN u.role = 3 THEN d.department_name
      ELSE NULL
  END AS department_name
FROM 
  users u
LEFT JOIN 
  student s ON u.user_id = s.user_id AND u.role = 1
LEFT JOIN 
  lecturer l ON u.user_id = l.user_id AND u.role = 2
LEFT JOIN 
  department d ON u.user_id = d.user_id AND u.role = 3
WHERE 
  u.user_id = $1;
`;
  const values = [userNumber];
  const result = await db.query(query, values);
  if (result.length > 0) {
    console.log("sau khi lay", result[0]);
    return result[0];
  } else {
    return null;
  }
};

module.exports = {
  getStudentById,
  updateStudent,
  updateLecture,
  updateDepartment,
  getUserInformationAndProfile,
  updateUserProfile,
  checkStudentExist,
  makeFollow,
  unFollow,
  getUserChat,
};
