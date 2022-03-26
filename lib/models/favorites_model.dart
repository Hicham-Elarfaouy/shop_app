class FavoritesModel {
  late bool status;
  String? message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);

  }
}

class Data {
  late List<DataProducts> data = [];

  Data.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element){
      data.add(DataProducts.fromJson(element));
    });
  }
}

class DataProducts {
  Product? product;

  DataProducts.fromJson(Map<String, dynamic> json){
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  int? price;
  int? oldprice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'].round();
    price = json['price'].round();
    oldprice = json['old_price'].round();
    discount = json['discount'].round();
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}