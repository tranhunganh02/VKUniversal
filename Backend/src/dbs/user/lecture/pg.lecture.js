const db = require("../../init.db.js");
const getLectureId = async (user_id) => {
     const query = `
         SELECT lecture_id FROM lecturer
         WHERE user_id = $1;
     `;
     const values = [user_id];
 
         const result = await db.query(query, values);
         return result[0];
    
 };
 module.exports = {
     getLectureId
 }