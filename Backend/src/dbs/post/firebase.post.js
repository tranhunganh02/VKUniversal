const firebaseAdmin = require('firebase-admin');

const storageFirebase = firebaseAdmin.storage()

async function uploadFileToFirebase(buffer, file) {
    try {
      // Tạo một unique key cho tệp
      const fileKey = firebaseAdmin.database().ref().push().key;
  
      // Xác định file_type dựa trên mimetype của tệp
      const file_type = getFileTypeFromMimetype(file.mimetype);
  
      // Lưu tệp vào Firebase Storage
      const bucket = storageFirebase.bucket();
      const fileDirectory = file_type
      const storageFilePath = `${fileDirectory}/${fileKey}`;
      const fileObject = bucket.file(storageFilePath);
      await fileObject.save(buffer, {
        metadata: {
          contentType: file.mimetype // Sử dụng mimetype của tệp để xác định kiểu dữ liệu
        }
      });
  
      // Lấy URL trực tiếp của tệp
      const [url] = await fileObject.getSignedUrl({
        action: 'read',
        expires: '03-09-2491' // Thời gian hết hạn của URL (VD: '03-09-2491')
    });
  
      // Trả về cả URL và file_type
      return  url ;
    } catch (error) {
      console.error('Error uploading file to Firebase:', error);
      throw new Error('Error uploading file to Firebase');
    }
  }

  async function updateFileFromFirebase(oldFileUrl, newFileBuffer, newFile) {
    try {
        // Xoá file cũ từ Firebase Storage
        await deleteFileFromFirebase(oldFileUrl)
        // Upload file mới lên Firebase Storage và nhận về URL mới
        const newFileUrl = await uploadFileToFirebase(newFileBuffer, newFile);

        // Trả về URL của tệp mới
        return newFileUrl;
    } catch (error) {
        console.error('Error updating file and returning URL:', error);
        throw new Error('Error updating file and returning URL');
    }
}

  
  // Hàm để xác định file_type từ mimetype
  function getFileTypeFromMimetype(mimetype) {
    if (mimetype.startsWith('image')) {
      return 'image';
    } else if (mimetype.startsWith('video')) {
      return 'video';
    } else {
      return 'other';
    }
  }
  
// Hàm để xoá một hình ảnh từ Firebase Storage
async function deleteFileFromFirebase (fileUrl) {
    try {
        const newFileUrl = await extractFilePath(fileUrl)
        // Logic để xoá tệp từ Firebase Storage, dựa vào fileUrl
        // Ví dụ:
        console.log("file sau khi cat", newFileUrl);
        const file = storageFirebase.bucket().file(newFileUrl);
        await file.delete();

        console.log(`File ${newFileUrl} deleted from Firebase Storage.`);
    } catch (error) {
        console.error('Error deleting file from Firebase:', error);
        throw new Error('Error deleting file from Firebase');
    }
};

async function extractFilePath(firebaseStorageLink) {
    // Loại bỏ phần đầu của link (https://storage.googleapis.com/.../)
    const pathStart = "https://storage.googleapis.com/test1-8afe3.appspot.com/";
    let filePath = firebaseStorageLink.substring(pathStart.length);
  
    // Loại bỏ phần truy vấn (?GoogleAccessId...)
    const queryStart = "?";
    if (filePath.includes(queryStart)) {
      filePath = filePath.split(queryStart)[0];
    }
  
    return filePath;
  }
  


module.exports = {
  updateFileFromFirebase,
    uploadFileToFirebase,
    deleteFileFromFirebase
};
