import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {

  static late SharedPreferences sharedPreferance;

  static init() async{
    sharedPreferance = await SharedPreferences.getInstance();
  }


  static dynamic getData({
    required String key,
  })async{
    return sharedPreferance.get(key);
  }

  static setData({
    required String key,
    required value,
})async{
    if(value is String) return await sharedPreferance.setString(key, value);
    if(value is int) return await sharedPreferance.setInt(key, value);
    if(value is bool) return await sharedPreferance.setBool(key, value);
     return await sharedPreferance.setDouble(key, value);
  }
}