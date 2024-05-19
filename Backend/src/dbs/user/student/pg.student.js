const db = require("../../init.db.js");
 const getStudentById = async (student_id) => {
     const query = `
         SELECT * FROM student
         WHERE student_id = $1;
     `;
     const values = [student_id];
 
     try {
         const result = await db.query(query, values);
         return result[0];
     } catch (error) {
         console.error('Error fetching student:', error);
         throw error;
     }
 };
 const updateStudent = async (student_id, major_id, class_id, student_code, surname, last_name, date_of_birth, gender) => {
     const query = `
         UPDATE student
         SET major_id = $2, class_id = $3, student_code = $4, surname = $5, last_name = $6, date_of_birth = $7, gender = $8
         WHERE student_id = $1
         RETURNING *;
     `;
     const values = [student_id, major_id, class_id, student_code, surname, last_name, date_of_birth, gender];
 
     try {
         const result = await db.query(query, values);
         return result[0];
     } catch (error) {
         console.error('Error updating student:', error);
         throw error;
     }
 };