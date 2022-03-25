class CategoriesModel{
  late bool status;
  late Data data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  List<DataModelCat> data = [];

  Data.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element){
      data.add(DataModelCat.fromJson(element));
    });
  }
}

class DataModelCat{
  late int id;
  late String name;
  late String image;

  DataModelCat.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}