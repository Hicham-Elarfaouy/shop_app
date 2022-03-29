class SearchModel {
  late bool status;
  String? message;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);

  }
}

class Data {
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element){
      data.add(Product.fromJson(element));
    });
  }
}

class Product {
  int? id;
  int? price;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'].round();
    price = json['price'].round();
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}