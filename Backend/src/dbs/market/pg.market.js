const db = require("../init.db.js");

const getCategoriesAndProductTypes = async () => {
  const query = `
         SELECT
           c.category_id,
           c.category_name,
           json_agg(json_build_object(
             'product_type_id', pt.product_type_id,
             'product_title', pt.product_title
           )) AS product_types
         FROM
           category c
         LEFT JOIN
           product_type pt ON c.category_id = pt.category_id
         GROUP BY
           c.category_id, c.category_name;
       `;
  const result = await db.query(query);
  return result[0];
};

const createMarketPost = async (
  productName,
  productType,
  price,
  detail,
  userId,
  address = null,
  image_url
) => {
  let query;
  let values;
  if (address == null) {
    console.log("address null");
    query = `
     INSERT INTO sell_post (product_name, product_type, price, detail, user_id, created_at, image_url)
     VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP, $6) RETURNING *;
   `;
    values = [productName, productType, price, detail, userId, image_url];
  } else {
    console.log("voi day");
    query = `
     INSERT INTO sell_post (product_name, product_type, price, detail, user_id, address, created_at, image_url)
     VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP, $7) RETURNING *;  `;
    values = [
      productName,
      productType,
      price,
      detail,
      userId,
      address,
      image_url,
    ];
  }

  const result = await db.query(query, values);
  return result[0];
};
const updateMarketPost = async (sellProductId, userId, updatedFields) => {
  let query = `UPDATE sell_post SET `;
  const values = [];
  let index = 1;

  // Xây dựng câu lệnh SQL cập nhật dựa trên các trường đã được chỉ định
  for (const field in updatedFields) {
    query += `${field} = $${index}, `;
    values.push(updatedFields[field]);
    index++;
  }

  // Thêm điều kiện cập nhật cho sản phẩm có product_id và user_id tương ứng
  query += `updated_at = CURRENT_TIMESTAMP WHERE sell_post_id = $${index} AND user_id = $${
    index + 1
  }`;

  // Thêm giá trị của product_id và user_id vào mảng values
  values.push(sellProductId);
  values.push(userId);

  // Thực hiện câu lệnh cập nhật và trả về kết quả
  const result = await db.query(`${query} RETURNING *`, values);

  return result[0];
};
const deleteMarketPostById = async (sellProductId, userId) => {
  const query = `DELETE FROM sell_post 
  WHERE sell_post_id = $1 AND user_id = $2
  `;
  try {
     await db.query(query, [sellProductId, userId]);
     return true
  } catch (error) {
     return false
  }
};
const getMarketPostById = async (sellProductId) => {
     const query = `SELECT * FROM sell_post WHERE sell_post_id = $1 ;`;
     const result = await db.query(query, [sellProductId]);
     return result[0];
   };
const getImagesMarketPostById = async (sellProductId, userId) => {
  const query = `SELECT image_url FROM sell_post WHERE sell_post_id = $1 AND user_id = $2;`;
  const result = await db.query(query, [sellProductId, userId]);
  return result[0];
};
const getAllMarketPost = async (orderBy="created_at", type_order_by ="desc", page=1) => {
    const limit = 6

    const offset = (page-1)*limit

    query = `SELECT sell_post_id, image_url[1], product_name, price FROM sell_post ORDER BY ${orderBy} ${type_order_by} LIMIT ${limit} OFFSET ${offset};`;

    const result = await db.query(query);
     
     return result;
   };
   

module.exports = {
  getCategoriesAndProductTypes,
  createMarketPost,
  updateMarketPost,
  deleteMarketPostById,
  getImagesMarketPostById,
  getMarketPostById,
  getAllMarketPost
};
