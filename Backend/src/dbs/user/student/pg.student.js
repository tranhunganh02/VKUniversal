const db = require("../../init.db.js");
 const getStudentByUserId = async (student_id) => {
     const query = `
         SELECT * FROM student
         WHERE student_id = $1;
     `;
     const values = [student_id];
 
         const result = await db.query(query, values);
         return result[0];
    
 };
 const updateStudent = async (student_id, major_id, class_id, student_code, surname, last_name, date_of_birth, gender) => {
    const query = `
         UPDATE student
         SET major_id = $2, class_id = $3, student_code = $4, surname = $5, last_name = $6, date_of_birth = $7, gender = $8
         WHERE student_id = $1
         RETURNING *;
     `;
    const values = [student_id, major_id, class_id, student_code, surname, last_name, date_of_birth, gender];
 
    const result = await db.query(query, values);
    return result[0];

 };

 const getStudentId = async (user_id) => {
    const query = `
        SELECT student_id FROM student
        WHERE user_id = $1;
    `;
    const values = [user_id];

    const result = await db.query(query, values);
    return result[0];

};

module.exports = {
    getStudentId,
    updateStudent,
    getStudentByUserId
}