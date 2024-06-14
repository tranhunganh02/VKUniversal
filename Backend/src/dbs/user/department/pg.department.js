const db = require("../../init.db.js");
const getDepartmentId = async (user_id) => {
     const query = `
         SELECT department_id FROM department
         WHERE user_id = $1;
     `;
     const values = [user_id];
 
         const result = await db.query(query, values);
         return result[0];
    
 };
 module.exports = {
     getDepartmentId
 }