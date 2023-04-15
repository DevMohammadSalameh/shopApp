class LoginModel{
  late bool status;
  late String message;
  late LoginData? data;

  LoginModel.fromJson(json){
    status = json["status"];
    message = json["message"];
    data =  json["data"]!=null ? LoginData.fromJson(json["data"]): null;
  }
}

class LoginData{
  late int id;
  late String name;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  LoginData.fromJson(json){
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}