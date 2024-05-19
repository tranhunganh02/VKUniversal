const { BadRequestError } = require("../../core/error.response");
const { NoContentSuccess } = require("../../core/success.response");
const { deleteFileFromFirebase } = require("../../dbs/market/firebase.market");
const {
  createMarketPost,
  updateMarketPost,
  getImagesMarketPostById,
  deleteMarketPostById,
  getMarketPostById,
  getAllMarketPost
} = require("../../dbs/market/pg.market");
const { uploadFileToFirebase } = require("../../dbs/post/firebase.post");
class MarketService {
  // create market post here
  static async createPost(user_id, payload, attachments) {
    //1.check missingg value
    //2. upload file image
    //3. insert to table sell_post
    const { product_name, product_type, price, detail, address } = payload;
    //check missing value
    if (!product_name || !product_type || !price || !detail || !attachments) {
      throw new BadRequestError("Some fields required are missing");
    }

    // upload file
    const attachmentURLs = await Promise.all(
      attachments.map(async (attachment) => {
        const url = await uploadFileToFirebase(attachment.buffer, attachment);
        console.log("url ", url);
        return url;
      })
    );
    if (!attachmentURLs) throw BadRequestError("Cannot push image");

    //insert to table sell_post
    const sell_post = createMarketPost(
      product_name,
      Number(product_type),
      parseFloat(price),
      detail,
      user_id,
      address,
      attachmentURLs
    );

    if (!sell_post) throw BadRequestError("Cannot create sell post");

    return sell_post;
  }
  static async updatePost(user_id, payload) {
     //1,. xoa link image ở firebase
    const sell_post_id = Number(payload.sell_post_id);

    if (!sell_post_id) throw new BadRequestError("Field missing");

    delete payload.sell_post_id;
     //2. xoá trong database
    const result = await updateMarketPost(sell_post_id, user_id, payload);

    if (!result) throw new BadRequestError("Cannot update");

    return result;
  }
  static async deleteMarketPost(user_id, payload) {
    let image_URl = await getImagesMarketPostById(
      payload.sell_post_id,
      user_id
    );

    console.log("a", image_URl);
    // Kiểm tra nếu image_url không phải là mảng, chuyển đổi nó thành mảng
    const imageUrls = Array.isArray(image_URl) ? image_URl : [image_URl];

    // Sử dụng phương thức map trên mảng imageUrls để thực hiện xóa tệp từ Firebase
    const deletePromises = imageUrls.map((url) => deleteFileFromFirebase(url));

    await Promise.all(deletePromises);

    const result = await deleteMarketPostById(payload.sell_post_id, user_id);

    if (!result) throw new BadRequestError("Cannot delete");

    return result;
  }

  static async getPostById(sell_post_id) {

    const result = await getMarketPostById((sell_post_id));
    if (!result) throw new BadRequestError("Cannot get data");

    return result;
  }
  static async getAllPost(order_by, type_order_by, page) {


     const result = await getAllMarketPost( order_by, type_order_by, page);

     if (!result) throw new BadRequestError("Cannot get data");

     return result;
  }
}

module.exports = MarketService;
