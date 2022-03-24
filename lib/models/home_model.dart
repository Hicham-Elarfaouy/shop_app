class HomeModel{
  late bool status;
  late DataModel data;

  HomeModel.Json(Map<String, dynamic> json){
    status = json['status'];
    data = DataModel.Json(json['data']);
  }
}

class DataModel{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  DataModel.Json(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannerModel.Json(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.Json(element));
    });
  }
}

class BannerModel{
  late int id;
  late String image;

  BannerModel.Json(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel{
  late int id;
  late int price;
  late int oldprice;
  late int discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.Json(Map<String, dynamic> json){
    id = json['id'].round();
    price = json['price'].round();
    oldprice = json['old_price'].round();
    discount = json['discount'].round();
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}