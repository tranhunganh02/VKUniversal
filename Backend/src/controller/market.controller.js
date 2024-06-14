const {
  CREATED,
  SuccessResponse,
  NoContentSuccess,
} = require("../core/success.response");
const MarketService = require("../services/market/market.service");

class MarketController {
  createMarket = async (req, res, next) => {
    new CREATED({
      message: "Created success",
      metadata: await MarketService.createPost(req.user.userId, req.body, req.files),
    }).send(res);
  };
  getMarketPost = async (req, res, next) => {
     const { sell_post_id } = req.query;
     new SuccessResponse({
       message: "Getdata success",
       metadata: await MarketService.getPostById(sell_post_id),
     }).send(res);
   };
   getAllMarketPost = async (req, res, next) => {
    const { order_by, type_order_by, page } = req.query;
     new SuccessResponse({
       message: "Getdata success",
       metadata: await MarketService.getAllPost(order_by, type_order_by, page),
     }).send(res);
   };
  updateMarket = async (req, res, next) => {
     new SuccessResponse({
       message: "Update success",
       metadata: await MarketService.updatePost(req.user.userId, req.body, req.files),
     }).send(res);
   };
   deleteMarket = async (req, res, next) => {
     new NoContentSuccess({
       message: "Delete success",
       metadata: await MarketService.deleteMarketPost(req.user.userId, req.body),
     }).send(res);
   };

}

module.exports = new MarketController();
