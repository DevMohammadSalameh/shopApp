class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json["status"];
    data = CategoriesDataModel.fromJson(json["data"]);
  }
}
class CategoriesDataModel{

  late int currentPage;
  late List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    currentPage = json["current_page"]!;
    json["data"].forEach((e){
      data.add(DataModel.fromJson(e));
    });
  }
}

class DataModel{
  late String name;
  late String image;

  DataModel.fromJson(Map<String,dynamic> json){
    name = json["name"]!;
    image = json["image"]!;

  }
}