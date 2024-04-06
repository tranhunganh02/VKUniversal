const{ createPost, getPostById, deletePostById, updatePost } = require('../../dbs/post/pg.post')

class PostService {

     // create post here
     // file_type:0 "image/jpg", :1"video"
     //post_type:0-> normal, :1-> thong bao do that lac
     static async createPost(content, user_id, privacy, post_type, attachment) {
          console.log("post in service: ", content, user_id, privacy, post_type, attachment);
          return await createPost(content, user_id, privacy, post_type, attachment);
     }

     static async findUserByEmail(email) {
          console.log("email in service: ", email);
          return await findUserByEmail(email);
     }

}

module.exports = PostService