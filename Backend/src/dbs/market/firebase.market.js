const firebaseAdmin = require('firebase-admin');

const storageFirebase = firebaseAdmin.storage()

async function deleteFileFromFirebase (fileUrl) {
     try {
         const newFileUrl = await extractFilePath(fileUrl)
         // Logic để xoá tệp từ Firebase Storage, dựa vào fileUrl
         // Ví dụ:
         console.log("file sau khi cat", newFileUrl);
         const file = storageFirebase.bucket().file(newFileUrl);
         await file.delete();
         return true
     } catch (error) {
          return false
     }
};


module.exports = {
       deleteFileFromFirebase
   };
   