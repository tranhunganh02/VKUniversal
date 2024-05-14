const db = require("../init.db.js");

// Get a student by student_id
const getStudentById = async (studentId) => {
  const query = `
    SELECT * FROM Student WHERE student_id = $1;
  `;
  const values = [studentId];
  const result = await db.query(query, values);
  return result.rows[0];
};

// Update student information
const updateStudent = async (userId, studentId, updates) => {
  console.log(`id: ${userId} ${studentId}`);
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
  query += ` WHERE student_id = $${updateFields.length + 1} AND user_id = $${
    updateFields.length + 2
  } RETURNING *;`;

  // Thêm giá trị studentId và userId vào mảng values
  values.push(studentId);
  values.push(userId);

  console.log(query);
  console.log(values);

  const result = await db.query(query, values);

  console.log(result);
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
  return result.rows[0];
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
  const query = ` Select bio from user_profile where user_id = $1;`;
  const values = [user_id];
  const result = await db.query(query, values);

  let query2 = null;
  if (role == 0) {
    query2 = `
    SELECT 
      s.user_id,
      s.student_code,
      s.surname,
      s.last_name,
      s.date_of_birth,
      s.gender,
      m.major_name,
      c.class_name
    FROM 
      student s
    JOIN 
      major m ON s.major_id = m.major_id
    JOIN 
      university_class c ON s.class_id = c.class_id
    WHERE 
      s.user_id = $1;
  `;
  } else if(role ==1 ){
    query2 =`
    SELECT 
      l.ar_name,
      d.degree_name,
      f.faculty_name,
      le.lecturer_code,
      le.user_id,
      le.gender,
      le.surname,
      le.last_name,
      le.date_of_birth
    FROM 
      lecturer le
    JOIN 
      academic_rank l ON le.academic_id = l.ar_id
    JOIN 
      degree d ON le.degree_id = d.degree_id
    JOIN 
      faculty f ON le.faculty_id = f.faculty_id;
    WHERE 
      le.user_id = $1;  
  `
  } else {
    return false
  }

  const result2 = await db.query(query2, values)

  return result[0], result2;
};

module.exports = {
  getStudentById,
  updateStudent,
  updateLecture,
  updateDepartment,
  getUserInformationAndProfile,
  updateUserProfile,
};
